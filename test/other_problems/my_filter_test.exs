defmodule MyFilterTest do
  use ExUnit.Case

  test "keep evens" do
    assert MyFilter.filter([1, 2, 3, 4, 5], fn x -> rem(x, 2) == 0 end) == [2, 4]
  end

  test "keep positives" do
    assert MyFilter.filter([-1, 0, 1, 2], fn x -> x > 0 end) == [1, 2]
  end

  test "nothing matches" do
    assert MyFilter.filter([1, 2, 3], fn x -> x > 10 end) == []
  end

  test "everything matches" do
    assert MyFilter.filter([1, 2, 3], fn _x -> true end) == [1, 2, 3]
  end

  test "empty list" do
    assert MyFilter.filter([], fn _x -> true end) == []
  end
end
