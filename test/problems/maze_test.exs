defmodule MazeTest do
  use ExUnit.Case

  test "simple straight path" do
    maze = [
      [:wall, :wall, :wall],
      [:start, :empty, :exit],
      [:wall, :wall, :wall]
    ]

    path = Maze.solve(maze)
    assert path == [:right, :right]
  end

  test "one turn" do
    maze = [
      [:wall, :wall, :wall, :wall],
      [:start, :empty, :wall, :wall],
      [:wall, :empty, :exit, :wall],
      [:wall, :wall, :wall, :wall]
    ]

    path = Maze.solve(maze)
    assert path == [:right, :down, :right]
  end

  test "longer path" do
    maze = [
      [:wall, :wall, :wall, :wall, :wall],
      [:wall, :start, :empty, :empty, :wall],
      [:wall, :wall, :wall, :empty, :wall],
      [:wall, :empty, :empty, :empty, :wall],
      [:wall, :exit, :wall, :wall, :wall]
    ]

    path = Maze.solve(maze)
    assert is_list(path)
    assert length(path) > 0
    # verify the path actually works
    assert valid_path?(maze, path) == true
  end

  test "no solution" do
    maze = [
      [:wall, :wall, :wall],
      [:start, :wall, :exit],
      [:wall, :wall, :wall]
    ]

    assert Maze.solve(maze) == :no_path
  end

  defp valid_path?(maze, path) do
    {start_r, start_c} = find_tile(maze, :start)
    {exit_r, exit_c} = find_tile(maze, :exit)

    {final_r, final_c} =
      Enum.reduce(path, {start_r, start_c}, fn dir, {r, c} ->
        case dir do
          :up -> {r - 1, c}
          :down -> {r + 1, c}
          :left -> {r, c - 1}
          :right -> {r, c + 1}
        end
      end)

    final_r == exit_r and final_c == exit_c
  end

  defp find_tile(maze, tile) do
    maze
    |> Enum.with_index()
    |> Enum.reduce_while(nil, fn {row, r}, _acc ->
      case Enum.find_index(row, &(&1 == tile)) do
        nil -> {:cont, nil}
        c -> {:halt, {r, c}}
      end
    end)
  end
end
