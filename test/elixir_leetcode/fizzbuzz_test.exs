defmodule FizzBuzzTest do
  use ExUnit.Case

  test "1 to 5" do
    assert FizzBuzz.run(5) == [1, 2, "Fizz", 4, "Buzz"]
  end

  test "1 to 15" do
    assert FizzBuzz.run(15) == [
      1, 2, "Fizz", 4, "Buzz",
      "Fizz", 7, 8, "Fizz", "Buzz",
      11, "Fizz", 13, 14, "FizzBuzz"
    ]
  end

  test "1 to 1" do
    assert FizzBuzz.run(1) == [1]
  end
end
