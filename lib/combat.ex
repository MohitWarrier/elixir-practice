defmodule Combat do
  def new_player(name, hp, attack_power) do
    %{name: name, hp: hp, max_hp: hp, attack_power: attack_power}
  end

  def name(player) do
    Map.get(player, :name)
  end

  def hp(player) do
    Map.get(player, :hp)
  end

  def max_hp(player) do
    Map.get(player, :max_hp)
  end

  def attack_power(player) do
    Map.get(player, :attack_power)
  end

  def alive?(player) do
    hp(player) > 0
  end

  def attack(attacker, defender) do
    updated_defender =
      take_damage(defender, attack_power(attacker))

    {attacker, updated_defender}
  end

  def take_damage(player, amount) do
    Map.put(player, :hp, max(hp(player) - amount, 0))
  end

  def heal(player, amount) do
    Map.put(player, :hp, min(hp(player) + amount, max_hp(player)))
  end

  def critical_attack(attacker, defender) do
    updated_defender =
      take_damage(defender, attack_power(attacker) * 2)

    {attacker, updated_defender}
  end
end
