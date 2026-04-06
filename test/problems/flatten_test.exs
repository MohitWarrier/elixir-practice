defmodule FlattenTest do
  use ExUnit.Case

  test "empty list" do
    assert Flatten.flatten([]) == []
  end

  test "already flat" do
    assert Flatten.flatten([1, 2, 3]) == [1, 2, 3]
  end

  test "one level deep" do
    assert Flatten.flatten([[1, 2], [3, 4]]) == [1, 2, 3, 4]
  end

  test "deeply nested" do
    assert Flatten.flatten([[1, [2]], [3, [4, 5]]]) == [1, 2, 3, 4, 5]
  end

  test "very deep" do
    assert Flatten.flatten([[[[[1]]]]]) == [1]
  end

  test "mixed" do
    assert Flatten.flatten([1, [2, [3], 4], 5]) == [1, 2, 3, 4, 5]
  end
end
