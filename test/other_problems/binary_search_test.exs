defmodule BinarySearchTest do
  use ExUnit.Case

  test "find middle element" do
    assert BinarySearch.search([1, 3, 5, 7, 9], 5) == {:ok, 2}
  end

  test "find first element" do
    assert BinarySearch.search([1, 3, 5, 7, 9], 1) == {:ok, 0}
  end

  test "find last element" do
    assert BinarySearch.search([1, 3, 5, 7, 9], 9) == {:ok, 4}
  end

  test "not found" do
    assert BinarySearch.search([1, 3, 5, 7, 9], 4) == :not_found
  end

  test "empty list" do
    assert BinarySearch.search([], 1) == :not_found
  end

  test "single element found" do
    assert BinarySearch.search([5], 5) == {:ok, 0}
  end

  test "single element not found" do
    assert BinarySearch.search([5], 3) == :not_found
  end

  test "large list" do
    list = Enum.to_list(0..999)
    assert BinarySearch.search(list, 756) == {:ok, 756}
  end
end
