defmodule MyList do

  def my_length([]) do
    0
  end

  def my_length([_head | tail]) do
    1 + my_length(tail)
  end

  def my_reverse(list) do
    reverse(list, [])
  end

  defp reverse([], acc) do
    acc
  end

  defp reverse([head|tail], acc) do
    reverse(tail, [head | acc])
  end

  def my_flatten([]) do
    []
  end

  def my_flatten([head|tail]) when is_list(head) do
    my_flatten(head) ++ my_flatten(tail)
  end

  def my_flatten([head|tail]) do
    [head | my_flatten(tail)]
  end
end
