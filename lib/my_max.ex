defmodule MyMax do

  def max([]) do
    nil
  end

  def max([x]) do
    x
  end

  def max([head|tail]) do
    tail_max = max(tail)

    if head > tail_max, do: head, else: tail_max
  end

end
