defmodule WordCountTest do
  use ExUnit.Case

  test "empty string" do
    assert WordCount.count("") == %{}
  end

  test "single word" do
    assert WordCount.count("hello") == %{"hello" => 1}
  end

  test "multiple words" do
    assert WordCount.count("hello world hello") == %{"hello" => 2, "world" => 1}
  end

  test "many repeats" do
    assert WordCount.count("a b a b a") == %{"a" => 3, "b" => 2}
  end
end
