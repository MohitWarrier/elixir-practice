defmodule MyTakeWhile do


  def take_while([], _func) do
    []
  end

  def take_while([head|tail], func) do

    if func.(head) == true do
      [head | take_while(tail, func)]
    else
      []
    end

  end

end
