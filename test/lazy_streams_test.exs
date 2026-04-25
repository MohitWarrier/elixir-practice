defmodule LazyStreamsTest do
  use ExUnit.Case

  test "first n even numbers" do
    assert LazyStreams.first_n_evens(5) == [2, 4, 6, 8, 10]
  end

  test "first n perfect squares" do
    assert LazyStreams.first_n_squares(5) == [1, 4, 9, 16, 25]
  end

  test "running sum" do
    assert LazyStreams.running_sum([1, 2, 3, 4, 5]) == [1, 3, 6, 10, 15]
  end

  test "cycle labels" do
    assert LazyStreams.cycle_labels(["a", "b", "c"], 7) == ["a", "b", "c", "a", "b", "c", "a"]
  end

  test "fibonacci sequence" do
    assert LazyStreams.fibonacci(8) == [1, 1, 2, 3, 5, 8, 13, 21]
  end
end
