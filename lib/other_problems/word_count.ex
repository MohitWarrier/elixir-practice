defmodule WordCount do


  def count(string) do
    string
    |> String.trim()
    |> String.split()
    |> Enum.reduce(%{}, fn x, acc ->
        Map.update(acc, x, 1, fn existing_value ->
         existing_value + 1 end)
    end)
  end
end
