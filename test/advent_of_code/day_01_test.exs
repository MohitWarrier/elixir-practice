# run this test with `mix test test/advent_of_code/day_01_test.exs`

defmodule AdventOfCode.Day01Test do
  use ExUnit.Case, async: true
  import AdventOfCode.Day01

  test "part1 sums the list" do
    input = [1, 2, 3, 4]
    assert part1(input) == 10
  end

  test "part2 sums even positive numbers only" do
    input = [1, 2, 3, 4, -6]
    assert part2(input) == 6
  end
end
