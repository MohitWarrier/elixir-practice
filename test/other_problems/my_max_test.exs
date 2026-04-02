defmodule MyMaxTest do
  use ExUnit.Case

  test "single element" do
    assert MyMax.max([5]) == 5
  end

  test "max at start" do
    assert MyMax.max([10, 3, 7]) == 10
  end

  test "max at end" do
    assert MyMax.max([1, 2, 9]) == 9
  end

  test "max in middle" do
    assert MyMax.max([3, 8, 2]) == 8
  end

  test "negative numbers" do
    assert MyMax.max([-5, -1, -10]) == -1
  end

  test "duplicates" do
    assert MyMax.max([3, 3, 3]) == 3
  end
end
