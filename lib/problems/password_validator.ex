defmodule OtherProblems.PasswordValidator do
  def part1(input) do
    lines = line_cleaner(input)
    IO.inspect(lines, label: "Lines")

    nums =
      Enum.map(lines, fn line ->
        String.to_integer(line)
      end)

    count_increases(nums)
  end

  defp count_increases(nums) do
    nums
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [prev, curr] -> curr > prev end)
  end

  # fix the \r problem
  defp line_cleaner(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
  end

  def part2(input) do
    input
    |> line_cleaner()
    |> parser()
    |> validator()
  end

  defp parser(input) do
    input
    |> Enum.map(fn line ->
      [policy, password] = String.split(line, ":", trim: true)
      [positions, character] = String.split(policy, " ", trim: true)
      character = String.trim(character)

      [position1, position2] =
        positions
        |> String.split("-", trim: true)
        |> Enum.map(&String.to_integer/1)

      {position1, position2, character, String.trim(password)}
    end)
  end

  defp validator(input) do
    input
    |> Enum.count(fn {pos1, pos2, char, password} ->
      char_at_pos1 = String.at(password, pos1 - 1)
      char_at_pos2 = String.at(password, pos2 - 1)
      char_at_pos1 == char != (char_at_pos2 == char)
    end)
  end
end
