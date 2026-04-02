defmodule MyMapTest do
  use ExUnit.Case

  test "double each element" do
    assert MyMap.map([1, 2, 3], fn x -> x * 2 end) == [2, 4, 6]
  end

  test "convert to strings" do
    assert MyMap.map([1, 2, 3], fn x -> to_string(x) end) == ["1", "2", "3"]
  end

  test "empty list" do
    assert MyMap.map([], fn x -> x end) == []
  end

  test "single element" do
    assert MyMap.map([5], fn x -> x + 1 end) == [6]
  end
end
