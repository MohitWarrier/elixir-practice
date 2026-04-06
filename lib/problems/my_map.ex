defmodule MyMap do

  def map([], _func) do
    []
  end

  def map([head|tail], func) do
   [func.(head) | map(tail, func)]
  end

end
