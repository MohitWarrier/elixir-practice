defmodule MyZipTest do
  use ExUnit.Case

  test "equal length" do
    assert MyZip.zip([1, 2, 3], [:a, :b, :c]) == [{1, :a}, {2, :b}, {3, :c}]
  end

  test "first shorter" do
    assert MyZip.zip([1, 2], [:a, :b, :c]) == [{1, :a}, {2, :b}]
  end

  test "second shorter" do
    assert MyZip.zip([1, 2, 3], [:a]) == [{1, :a}]
  end

  test "both empty" do
    assert MyZip.zip([], []) == []
  end

  test "one empty" do
    assert MyZip.zip([], [1, 2]) == []
  end
end
