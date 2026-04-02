defmodule MyFilter do
  def filter([], _func) do
    []
  end

  def filter([head | tail], func) do
    if func.(head) == true do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end
end
