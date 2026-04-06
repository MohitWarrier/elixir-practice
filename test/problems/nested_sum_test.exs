defmodule NestedSumTest do
  use ExUnit.Case

  test "flat list" do
    assert NestedSum.sum([1, 2, 3]) == 6
  end

  test "one level nested" do
    assert NestedSum.sum([1, [2, 3], 4]) == 10
  end

  test "deeply nested" do
    assert NestedSum.sum([1, [2, [3, [4]]]]) == 10
  end

  test "empty list" do
    assert NestedSum.sum([]) == 0
  end

  test "empty nested lists" do
    assert NestedSum.sum([[], [1], []]) == 1
  end
end
