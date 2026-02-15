defmodule ElixirLeetcode.TwoSum do
  @doc """
  Given an array of integers `nums` and an integer `target`, return the indices
  of the two numbers such that they add up to `target`.

  Each input has exactly one solution, and you may not use the same element twice.
  """
  def two_sum(nums, target) do
    nums
    |> Enum.with_index()
    |> Enum.reduce_while(%{}, fn {num, index}, seen ->
      complement = target - num

      case Map.get(seen, complement) do
        nil -> {:cont, Map.put(seen, num, index)}
        comp_index -> {:halt, [comp_index, index]}
      end
    end)
    
  end
end
