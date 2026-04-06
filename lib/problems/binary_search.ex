defmodule BinarySearch do
  def search([], _num) do
    :not_found
  end

  def search(list, num) do
    list
    |> List.to_tuple()
    |> binary_search(num)
  end

  defp binary_search(tuple, num) do
    size = tuple_size(tuple)

    Enum.reduce_while(0..size, {0, size - 1}, fn _x, {low, high} ->
      mid = div(low + high, 2)

      cond do
        low > high ->
          {:halt, :not_found}

        elem(tuple, mid) == num ->
          {:halt, {:ok, mid}}

        elem(tuple, mid) < num ->
          {:cont, {mid + 1, high}}

        elem(tuple, mid) > num ->
          {:cont, {low, mid - 1}}
      end
    end)
  end
end
