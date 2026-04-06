defmodule MyReduceTest do
  use ExUnit.Case

  test "sum" do
    assert MyReduce.reduce([1, 2, 3], 0, fn x, acc -> x + acc end) == 6
  end

  test "product" do
    assert MyReduce.reduce([2, 3, 4], 1, fn x, acc -> x * acc end) == 24
  end

  test "build a list" do
    assert MyReduce.reduce([1, 2, 3], [], fn x, acc -> [x | acc] end) == [3, 2, 1]
  end

  test "empty list returns initial acc" do
    assert MyReduce.reduce([], 42, fn _x, acc -> acc end) == 42
  end

  test "single element" do
    assert MyReduce.reduce([5], 0, fn x, acc -> x + acc end) == 5
  end
end
