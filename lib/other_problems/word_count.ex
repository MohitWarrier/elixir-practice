defmodule WordCount do

  # can play around with regex to get a more robust filter
  def count(string) do
    string
    |> String.downcase()
    |> String.replace(~r/[[:punct:]]/, "")
    |> String.replace(~r/\s+/, " ")
    |> String.trim()
    |> String.split()
    |> Enum.frequencies()
  end

end
