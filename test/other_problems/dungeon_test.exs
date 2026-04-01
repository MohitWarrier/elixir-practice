defmodule DungeonTest do
  use ExUnit.Case

  # Map legend:
  # :wall  - can't walk through
  # :empty - open space
  # :coin  - collect for points
  # :exit  - reach here to win

  @simple_map [
    [:wall,  :wall,  :wall,  :wall,  :wall],
    [:wall,  :empty, :coin,  :empty, :wall],
    [:wall,  :empty, :wall,  :empty, :wall],
    [:wall,  :empty, :empty, :coin,  :wall],
    [:wall,  :wall,  :wall,  :exit,  :wall]
  ]

  test "new game sets player position and score" do
    game = Dungeon.new(@simple_map, {1, 1})
    assert Dungeon.player_pos(game) == {1, 1}
    assert Dungeon.score(game) == 0
    assert Dungeon.status(game) == :playing
  end

  test "move to empty space" do
    game = Dungeon.new(@simple_map, {1, 1})
    game = Dungeon.move(game, :down)
    assert Dungeon.player_pos(game) == {2, 1}
  end

  test "cannot move into wall" do
    game = Dungeon.new(@simple_map, {1, 1})
    game = Dungeon.move(game, :left)
    assert Dungeon.player_pos(game) == {1, 1}
  end

  test "collect coin increases score" do
    game = Dungeon.new(@simple_map, {1, 1})
    game = Dungeon.move(game, :right)
    assert Dungeon.score(game) == 1
  end

  test "coin disappears after collection" do
    game = Dungeon.new(@simple_map, {1, 1})
    game = Dungeon.move(game, :right)
    game = Dungeon.move(game, :left)
    game = Dungeon.move(game, :right)
    assert Dungeon.score(game) == 1
  end

  test "reaching exit wins the game" do
    game = Dungeon.new(@simple_map, {3, 3})
    game = Dungeon.move(game, :down)
    assert Dungeon.status(game) == :won
  end

  test "cannot move after winning" do
    game = Dungeon.new(@simple_map, {3, 3})
    game = Dungeon.move(game, :down)
    game = Dungeon.move(game, :up)
    assert Dungeon.player_pos(game) == {4, 3}
    assert Dungeon.status(game) == :won
  end

  test "full playthrough" do
    game = Dungeon.new(@simple_map, {1, 1})
    game =
      game
      |> Dungeon.move(:right)       # collect coin at {1,2}
      |> Dungeon.move(:right)       # {1,3}
      |> Dungeon.move(:down)        # {2,3}
      |> Dungeon.move(:down)        # {3,3} collect coin
      |> Dungeon.move(:down)        # {4,3} exit!

    assert Dungeon.score(game) == 2
    assert Dungeon.status(game) == :won
  end
end
