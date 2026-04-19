defmodule CliParserTest do
  use ExUnit.Case

  # parse/1 takes a list of string tokens (argv) and returns {:ok, map} or {:error, reason}

  # --- flags (boolean, no value) ---
  test "parses a single flag" do
    assert CliParser.parse(["--verbose"]) == {:ok, %{verbose: true}}
  end

  test "parses multiple flags" do
    assert CliParser.parse(["--verbose", "--dry-run"]) == {:ok, %{verbose: true, dry_run: true}}
  end

  # --- options (key=value pairs) ---
  test "parses a single option" do
    assert CliParser.parse(["--output=file.txt"]) == {:ok, %{output: "file.txt"}}
  end

  test "parses multiple options" do
    assert CliParser.parse(["--output=file.txt", "--count=5"]) ==
             {:ok, %{output: "file.txt", count: "5"}}
  end

  # --- positional arguments ---
  test "parses a single positional argument" do
    assert CliParser.parse(["hello"]) == {:ok, %{args: ["hello"]}}
  end

  test "parses multiple positional arguments" do
    assert CliParser.parse(["hello", "world"]) == {:ok, %{args: ["hello", "world"]}}
  end

  # --- mixed ---
  test "parses flags, options, and positional args together" do
    result = CliParser.parse(["--verbose", "--output=out.txt", "input.txt"])
    assert result == {:ok, %{verbose: true, output: "out.txt", args: ["input.txt"]}}
  end

  # --- edge cases ---
  test "empty input returns empty map" do
    assert CliParser.parse([]) == {:ok, %{}}
  end

  test "unknown flag (not --) is treated as positional arg" do
    assert CliParser.parse(["-v"]) == {:ok, %{args: ["-v"]}}
  end

  test "returns error for malformed option (-- but no = and no value)" do
    assert CliParser.parse(["--"]) == {:error, "malformed argument: --"}
  end
end
