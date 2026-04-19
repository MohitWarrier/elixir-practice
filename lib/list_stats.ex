defmodule ListStats do
  @spec summary([number()]) :: %{
          min: number() | nil,
          max: number() | nil,
          sum: number(),
          avg: float() | nil,
          count: non_neg_integer()
        }
  def summary([]) do
    %{min: nil, max: nil, sum: 0, avg: nil, count: 0}
  end

  def summary(list) do
    Enum.reduce(list, %{min: hd(list), max: hd(list), sum: 0, count: 0}, fn x, acc ->
      %{acc | min: min(acc.min, x), max: max(acc.max, x), sum: acc.sum + x, count: acc.count + 1}
    end)
    |> then(fn result -> Map.put(result, :mean, result.sum / result.count) end)
    |> then(fn result -> Map.put(result, :median, find_median(list)) end)
    |> then(fn result -> Map.put(result, :mode, find_mode(list)) end)
  end

  defp find_median(list) do
    sorted = Enum.sort(list)
    len = length(sorted)

    if rem(len, 2) == 1 do
      Enum.at(sorted, div(len, 2))
    else
      mid1 = Enum.at(sorted, div(len, 2) - 1)
      mid2 = Enum.at(sorted, div(len, 2))
      (mid1 + mid2) / 2
    end
  end

  defp find_mode(list) do
    list
    |> Enum.frequencies()
    |> Enum.max_by(fn {_num, count} -> count end)
    |> elem(0)
  end
end
