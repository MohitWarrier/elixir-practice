defmodule RLE do
  def encode("") do
    ""
  end

  def encode(string) do
    string
    |> String.graphemes()
    # same as fn x -> x end
    |> Enum.chunk_by(& &1)
    |> Enum.map(&encoder/1)
    |> to_string()
  end

  defp encoder(list) when length(list) > 1 do
    hd(list) <> to_string(Enum.count(list))
  end

  defp encoder(list) do
    hd(list)
  end

  def decode("") do
    ""
  end

  def decode(string) do
    {result, _} =
      string
      |> String.graphemes()
      |> Enum.map_reduce("", fn char, prev ->
        case Integer.parse(char) do
          {num, ""} -> {String.duplicate(prev, max(num - 1, 0)), prev}
          :error -> {char, char}
        end
      end)

    Enum.join(result)
  end
end
