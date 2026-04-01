defmodule RLETest do
  use ExUnit.Case

  test "encode basic" do
    assert RLE.encode("aaabbc") == "a3b2c"
  end

  test "encode no repeats" do
    assert RLE.encode("abcd") == "abcd"
  end

  test "encode single char" do
    assert RLE.encode("aaaa") == "a4"
  end

  test "encode empty" do
    assert RLE.encode("") == ""
  end

  test "decode basic" do
    assert RLE.decode("a3b2c") == "aaabbc"
  end

  test "decode no numbers" do
    assert RLE.decode("abcd") == "abcd"
  end

  test "decode empty" do
    assert RLE.decode("") == ""
  end

  test "roundtrip" do
    original = "aaabbbccccdd"
    assert original |> RLE.encode() |> RLE.decode() == original
  end
end
