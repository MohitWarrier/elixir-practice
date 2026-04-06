defmodule Maze do
  def solve(maze) do
    start = start(maze)
    explore(maze, start, MapSet.new(), [])
  end

  defp start(maze) do
    row =
      Enum.find_index(maze, fn r ->
        Enum.member?(r, :start)
      end)

    col =
      Enum.find_index(
        Enum.at(maze, row),
        fn cell -> cell == :start end
      )

    {row, col}
  end

  defp move({row, col}, direction) do
    case direction do
      :up -> {row - 1, col}
      :down -> {row + 1, col}
      :left -> {row, col - 1}
      :right -> {row, col + 1}
    end
  end

  defp check_tile(maze, {row, col}) when row >= 0 and col >=0 do
    maze |> Enum.at(row) |> Enum.at(col)
  end

  defp check_tile(_maze, {_row, _col}) do
    nil
  end

  defp explore(maze, position, visited, path) do
    tile = check_tile(maze, position)
    visited? = MapSet.member?(visited, position)

    cond do
      tile == :exit ->
        path

      tile == :wall ->
        :no_path

      tile == :nil -> IO.puts("hello")
        :no_path

      visited? ->
        :no_path

      true ->
        visited = MapSet.put(visited, position)

        [:up, :down, :left, :right]
        |> Enum.find_value(:no_path, fn dir ->
          result = explore(maze, move(position, dir), visited, path ++ [dir])

          if result != :no_path do
            result
          end
        end)
    end
  end
end
