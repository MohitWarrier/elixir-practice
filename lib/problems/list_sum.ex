defmodule OtherProblems.ListSum do
  def part1(numbers) do
    Enum.sum(numbers)
  end

  def part2(numbers) do
    numbers
    |> Enum.filter(fn n -> n >= 0 end)
    |> Enum.filter(fn n -> rem(n, 2) == 0 end)
    |> Enum.sum()
  end
end
