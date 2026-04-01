defmodule ReverseListTest do
  use ExUnit.Case

  test "empty list" do
    assert ReverseList.reverse([]) == []
  end

  test "single element" do
    assert ReverseList.reverse([1]) == [1]
  end

  test "multiple elements" do
    assert ReverseList.reverse([1, 2, 3, 4, 5]) == [5, 4, 3, 2, 1]
  end

  test "strings" do
    assert ReverseList.reverse(["a", "b", "c"]) == ["c", "b", "a"]
  end

  test "nested lists stay intact" do
    assert ReverseList.reverse([[1, 2], [3, 4]]) == [[3, 4], [1, 2]]
  end
end
