defmodule ElixirLeetcode.TwoSumTest do
  use ExUnit.Case, async: true
  import ElixirLeetcode.TwoSum

  test "basic case: two numbers at the start" do
    assert two_sum([2, 7, 11, 15], 9) == [0, 1]
  end

  test "answer not at the beginning" do
    assert two_sum([3, 2, 4], 6) == [1, 2]
  end

  test "same number used twice" do
    assert two_sum([3, 3], 6) == [0, 1]
  end

  test "negative numbers" do
    assert two_sum([-1, -2, -3, -4, -5], -8) == [2, 4]
  end

  test "mix of negative and positive" do
    assert two_sum([-3, 4, 3, 90], 0) == [0, 2]
  end

  test "target involves zero" do
    assert two_sum([0, 4, 3, 0], 0) == [0, 3]
  end

  test "large values" do
    assert two_sum([1_000_000, 500, 999_500], 1_000_000) == [1, 2]
  end

  test "answer at the end of a longer list" do
    assert two_sum([1, 5, 8, 3, 12, 7], 19) == [4, 5]
  end

  test "two element list" do
    assert two_sum([1, 2], 3) == [0, 1]
  end
end
