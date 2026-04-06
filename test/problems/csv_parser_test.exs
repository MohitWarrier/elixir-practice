defmodule CsvParserTest do
  use ExUnit.Case

  @csv """
  name,age,city
  alice,30,london
  bob,25,paris
  charlie,35,london
  diana,28,paris
  eve,30,berlin
  """

  test "parse returns list of maps" do
    result = CsvParser.parse(@csv)
    assert length(result) == 5
    assert hd(result) == %{"name" => "alice", "age" => "30", "city" => "london"}
  end

  test "get column values" do
    result = CsvParser.parse(@csv) |> CsvParser.column("name")
    assert result == ["alice", "bob", "charlie", "diana", "eve"]
  end

  test "filter rows" do
    result =
      CsvParser.parse(@csv)
      |> CsvParser.where("city", "london")

    assert length(result) == 2
    assert Enum.map(result, & &1["name"]) == ["alice", "charlie"]
  end

  test "sort by column" do
    result =
      CsvParser.parse(@csv)
      |> CsvParser.sort_by("age")

    names = Enum.map(result, & &1["name"])
    assert hd(names) == "bob"
  end

  test "unique values in column" do
    result =
      CsvParser.parse(@csv)
      |> CsvParser.unique("city")

    assert Enum.sort(result) == ["berlin", "london", "paris"]
  end

  test "count by column" do
    result =
      CsvParser.parse(@csv)
      |> CsvParser.count_by("city")

    assert result == %{"london" => 2, "paris" => 2, "berlin" => 1}
  end
end
