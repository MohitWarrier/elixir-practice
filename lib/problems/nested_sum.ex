defmodule NestedSum do

  def sum([]) do
    0
  end

  def sum([head|tail]) when is_list(head) do
    sum(head) + sum(tail)
  end

  def sum([head|tail]) do
    head + sum(tail)
  end

end
