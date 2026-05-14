using DataFrames
using IncCSV
using Test

const SPEC_ROOT = normpath(joinpath(@__DIR__, ".."))
const POSITIVE = joinpath(SPEC_ROOT, "fixtures", "positive")
const NEGATIVE = joinpath(SPEC_ROOT, "fixtures", "negative")
const ROUNDTRIP = joinpath(SPEC_ROOT, "fixtures", "roundtrip")

asstrings(xs) = string.(collect(xs))

function rows_as_strings(df::DataFrame, columns)
    return [[string(row[col]) for col in columns] for row in eachrow(df)]
end

function read_df(path)
    return readinc(path, DataFrame)
end

function assert_table(file, columns, rows)
    df = table(file)
    @test names(df) == columns
    @test rows_as_strings(df, columns) == rows
end

@testset "INC spec conformance: Julia" begin
    @testset "Positive read fixtures" begin
        file = read_df(joinpath(POSITIVE, "basic.inc"))
        @test metadata(file)["title"] == "Basic data"
        @test metadata(file)["version"] == 1
        @test metadata(file)["columns"]["score"] == "points"
        assert_table(file, ["name", "score"], [["Ada", "21"], ["Babbage", "12"]])

        file = read_df(joinpath(POSITIVE, "plain.csv"))
        @test isempty(metadata(file))
        assert_table(file, ["name", "score"], [["Ada", "21"], ["Babbage", "12"]])

        file = read_df(joinpath(POSITIVE, "semicolon_structure.inc"))
        @test metadata(file)["structure"]["delimiter"] == ";"
        assert_table(file, ["name", "score"], [["Ada", "21"], ["Babbage", "12"]])

        file = read_df(joinpath(POSITIVE, "tab_structure.inc"))
        @test metadata(file)["structure"]["delim"] == "tab"
        assert_table(file, ["name", "score"], [["Ada", "21"], ["Babbage", "12"]])

        file = read_df(joinpath(POSITIVE, "quotechar_structure.inc"))
        @test metadata(file)["structure"]["quotechar"] == "'"
        assert_table(file, ["name", "note"], [["Ada", "hello, world"]])

        file = read_df(joinpath(POSITIVE, "escapechar_structure.inc"))
        @test metadata(file)["structure"]["escapechar"] == "|"
        assert_table(file, ["name", "note"], [["Ada", "say \"hi\""]])

        file = read_df(joinpath(POSITIVE, "header_footerskip_structure.inc"))
        @test metadata(file)["structure"]["header"] == 2
        @test metadata(file)["structure"]["footerskip"] == 1
        assert_table(file, ["name", "score"], [["Ada", "21"], ["Babbage", "12"]])

        file = read_df(joinpath(POSITIVE, "metadata_edge_cases.inc"))
        @test metadata(file)["empty"] == ""
        @test metadata(file)["hash"] == "#"
        @test metadata(file)["semicolon"] == ";"
        @test metadata(file)["path"] == raw"C:\tmp\data"
        @test metadata(file)["quoted"] == "say \"hi\" with \\"
        @test metadata(file)["id"] == "007"
        @test metadata(file)["offset"] == -3
        assert_table(file, ["name", "value"], [["Ada", "1"]])

        file = read_df(joinpath(POSITIVE, "unicode.inc"))
        @test metadata(file)["title"] == "Café temperatures"
        @test metadata(file)["city"] == "München"
        @test metadata(file)["測定"] == "温度"
        @test metadata(file)["columns"]["temperature"] == "°C"
        @test metadata(file)["columns"]["名前"] == "participant name"
        assert_table(file, ["name", "temperature", "note"], [["Anaïs", "21", "café"], ["李", "22", "東京"]])
    end

    @testset "Mini-schema fixture" begin
        schema = readschema(joinpath(POSITIVE, "schema.inc"))
        file = read_df(joinpath(POSITIVE, "schema_target_valid.inc"))
        report = validateschema(file, schema)

        @test report.valid
        @test isempty(report.missing)
        @test isempty(report.extra)
        @test isempty(report.forbidden)
    end

    @testset "Negative fixtures" begin
        invalid_read_files = [
            "missing_closing_delimiter.inc",
            "empty_section.inc",
            "invalid_key.inc",
            "invalid_section_key.inc",
            "repeated_key.inc",
            "unsupported_structure_key.inc",
            "invalid_structure_char.inc",
            "invalid_structure_int.inc",
        ]

        for name in invalid_read_files
            @test_throws ArgumentError read_df(joinpath(NEGATIVE, name))
        end

        invalid_schema_files = [
            "schema_deep_path.inc",
            "schema_duplicate_requirement.inc",
        ]

        for name in invalid_schema_files
            @test_throws ArgumentError readschema(joinpath(NEGATIVE, name))
        end
    end

    @testset "Canonical round trips" begin
        path = tempname()
        writeinc(
            path,
            [(name="Ada", score="21"), (name="Babbage", score="12")];
            metadata=Dict(
                "title" => "Roundtrip data",
                "version" => 1,
                "columns" => Dict("score" => "points"),
            ),
        )
        @test read(path, String) == read(joinpath(ROUNDTRIP, "basic_expected.inc"), String)

        file = read_df(path)
        assert_table(file, ["name", "score"], [["Ada", "21"], ["Babbage", "12"]])

        path = tempname()
        writeinc(
            path,
            [(name="Ada", value="1")];
            metadata=Dict(
                "id" => "007",
                "note" => "say \"hi\" with \\",
                "path" => raw"C:\tmp\data",
            ),
        )
        @test read(path, String) == read(joinpath(ROUNDTRIP, "escaped_expected.inc"), String)

        file = read_df(path)
        @test metadata(file)["id"] == "007"
        @test metadata(file)["note"] == "say \"hi\" with \\"
        @test metadata(file)["path"] == raw"C:\tmp\data"
        assert_table(file, ["name", "value"], [["Ada", "1"]])

        canonical = joinpath(ROUNDTRIP, "basic_expected.inc")
        file = read_df(canonical)
        path = tempname()
        writeinc(path, table(file); metadata=metadata(file))
        @test read(path, String) == read(canonical, String)
    end
end
