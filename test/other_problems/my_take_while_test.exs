defmodule MyTakeWhileTest do
  use ExUnit.Case

  test "take while positive" do
    assert MyTakeWhile.take_while([1, 2, 3, -1, 5], fn x -> x > 0 end) == [1, 2, 3]
  end

  test "all match" do
    assert MyTakeWhile.take_while([1, 2, 3], fn x -> x > 0 end) == [1, 2, 3]
  end

  test "none match" do
    assert MyTakeWhile.take_while([1, 2, 3], fn x -> x > 10 end) == []
  end

  test "empty list" do
    assert MyTakeWhile.take_while([], fn _x -> true end) == []
  end

  test "stops at first false" do
    assert MyTakeWhile.take_while([2, 4, 5, 6, 8], fn x -> rem(x, 2) == 0 end) == [2, 4]
  end
end
