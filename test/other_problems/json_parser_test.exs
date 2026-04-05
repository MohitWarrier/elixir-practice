defmodule JsonParserTest do
  use ExUnit.Case

  test "parses null" do
    assert JsonParser.parse("null") == nil
  end

  test "parses true" do
    assert JsonParser.parse("true") == true
  end

  test "parses false" do
    assert JsonParser.parse("false") == false
  end

  test "parses integer" do
    assert JsonParser.parse("42") == 42
  end

  test "parses negative integer" do
    assert JsonParser.parse("-7") == -7
  end

  test "parses float" do
    assert JsonParser.parse("3.14") == 3.14
  end

  test "parses string" do
    assert JsonParser.parse("\"hello\"") == "hello"
  end

  test "parses empty string" do
    assert JsonParser.parse("\"\"") == ""
  end

  test "parses empty array" do
    assert JsonParser.parse("[]") == []
  end

  test "parses array of numbers" do
    assert JsonParser.parse("[1,2,3]") == [1, 2, 3]
  end

  test "parses array of mixed types" do
    assert JsonParser.parse("[1,true,null]") == [1, true, nil]
  end

  test "parses empty object" do
    assert JsonParser.parse("{}") == %{}
  end

  test "parses object with one key" do
    assert JsonParser.parse("{\"name\":\"alice\"}") == %{"name" => "alice"}
  end

  test "parses object with multiple keys" do
    result = JsonParser.parse("{\"a\":1,\"b\":true}")
    assert result == %{"a" => 1, "b" => true}
  end

  test "parses nested object" do
    result = JsonParser.parse("{\"user\":{\"age\":30}}")
    assert result == %{"user" => %{"age" => 30}}
  end

  test "parses array of objects" do
    result = JsonParser.parse("[{\"a\":1},{\"b\":2}]")
    assert result == [%{"a" => 1}, %{"b" => 2}]
  end
end
