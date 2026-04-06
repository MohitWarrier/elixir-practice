defmodule Dungeon do
  def new(map, {row, col}) do
    %{grid: map, position: {row, col}, score: 0, status: :playing}
  end

  def move(game, direction) do
    case status(game) do
      :won ->
        game

      :playing ->
        move_helper(game, direction)
    end
  end

  def player_pos(game) do
    Map.get(game, :position)
  end

  def score(game) do
    Map.get(game, :score)
  end

  def status(game) do
    Map.get(game, :status)
  end

  defp move_helper(game, direction) do
    {r, c} = player_pos(game)

    case direction do
      :up ->
        grid_checker(game, {r - 1, c})

      :down ->
        grid_checker(game, {r + 1, c})

      :right ->
        grid_checker(game, {r, c + 1})

      :left ->
        grid_checker(game, {r, c - 1})

      _ ->
        game
    end
  end

  defp grid_checker(game, {r, c}) do
    grid = Map.get(game, :grid)
    checked_pos = grid |> Enum.at(r) |> Enum.at(c)

    case checked_pos do
      :wall ->
        game

      :empty ->
        Map.put(game, :position, {r, c})

      :coin ->
        game
        |> Map.put(:position, {r, c})
        |> Map.put(:score, game.score + 1)
        |> Map.update(:grid, [], fn grid ->
          List.update_at(grid, r, fn row ->
            List.update_at(row, c, fn _cell -> :empty end)
          end)
        end)

      :exit ->
        game
        |> Map.put(:position, {r, c})
        |> Map.put(:status, :won)
    end
  end
end
