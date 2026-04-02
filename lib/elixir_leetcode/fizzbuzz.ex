defmodule FizzBuzz do
  def run(n) when n < 1 do
    []
  end

  def run(n) do
    # build list from 1 to n, map each number to a string
    Enum.map(1..n, &classify/1)
  end

  defp classify(n) when rem(n, 3) == 0 and rem(n, 5) == 0 do
    "FizzBuzz"
  end

  defp classify(n) when rem(n, 3) == 0 do
    "Fizz"
  end

  defp classify(n) when rem(n, 5) == 0 do
    "Buzz"
  end

  defp classify(n) do
    n
  end
end
