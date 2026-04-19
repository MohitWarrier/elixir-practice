defmodule CombatTest do
  use ExUnit.Case

  test "create player and enemy" do
    player = Combat.new_player("Hero", 100, 15)
    assert Combat.name(player) == "Hero"
    assert Combat.hp(player) == 100
    assert Combat.max_hp(player) == 100
    assert Combat.attack_power(player) == 15
    assert Combat.alive?(player) == true
  end

  test "attack deals damage" do
    player = Combat.new_player("Hero", 100, 15)
    enemy = Combat.new_player("Goblin", 40, 8)
    {_player, enemy} = Combat.attack(player, enemy)
    assert Combat.hp(enemy) == 25
  end

  test "hp cannot go below 0" do
    player = Combat.new_player("Hero", 100, 50)
    enemy = Combat.new_player("Goblin", 30, 8)
    {_player, enemy} = Combat.attack(player, enemy)
    assert Combat.hp(enemy) == 0
    assert Combat.alive?(enemy) == false
  end

  test "heal restores hp" do
    player = Combat.new_player("Hero", 100, 15)
    player = Combat.take_damage(player, 40)
    assert Combat.hp(player) == 60
    player = Combat.heal(player, 20)
    assert Combat.hp(player) == 80
  end

  test "heal cannot exceed max hp" do
    player = Combat.new_player("Hero", 100, 15)
    player = Combat.take_damage(player, 10)
    player = Combat.heal(player, 50)
    assert Combat.hp(player) == 100
  end

  test "battle sequence" do
    player = Combat.new_player("Hero", 100, 20)
    enemy = Combat.new_player("Dragon", 50, 12)

    # player attacks
    {player, enemy} = Combat.attack(player, enemy)
    assert Combat.hp(enemy) == 30

    # enemy attacks back
    {enemy, player} = Combat.attack(enemy, player)
    assert Combat.hp(player) == 88

    # player attacks again
    {player, enemy} = Combat.attack(player, enemy)
    assert Combat.hp(enemy) == 10

    # player finishes it
    {_player, enemy} = Combat.attack(player, enemy)
    assert Combat.hp(enemy) == 0
    assert Combat.alive?(enemy) == false
  end

  test "critical hit deals double damage" do
    player = Combat.new_player("Hero", 100, 20)
    enemy = Combat.new_player("Goblin", 100, 5)
    {_player, enemy} = Combat.critical_attack(player, enemy)
    assert Combat.hp(enemy) == 60
  end
end
