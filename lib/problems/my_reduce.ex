defmodule MyReduce do

  def reduce([], acc, _func) do
    acc
  end

  def reduce([head|tail], acc, func) do
    reduce(tail, func.(head, acc), func)
  end

end
