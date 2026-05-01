defmodule JsonParser do
  def parse(string) do
    case string do
      "null" ->
        nil

      "true" ->
        true

      "false" ->
        false

      "[" <> _ ->
        handle_array(string)

      "{" <> _ ->
        handle_object(string)

      _ ->
        case Integer.parse(string) do
          {n, ""} ->
            n

          _ ->
            case Float.parse(string) do
              {f, ""} -> f
              _ -> String.replace(string, "\"", "")
            end
        end
    end
  end

  def handle_array(string) do
    string
    |> String.slice(1..-2//1)
    |> split_top_level(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse/1)
  end

  defp handle_object(string) do
    string
    |> String.slice(1..-2//1)
    |> split_top_level(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> split_top_level(x, ":") end)
    |> Enum.map(fn x ->
      Enum.map(x, &parse/1)
    end)
    |> Map.new(fn [k, v] -> {k, v} end)
  end

  # we need a smart splitter
  # String.split splits on any seperator no
  # matter the depth
  defp split_top_level(string, _seperator)
       when string == "" do
    []
  end

  defp split_top_level(string, seperator) do
    {list, last, _} =
      string
      |> String.graphemes()
      |> Enum.reduce(
        {[], "", 0},
        fn char, {acc, cur, depth} ->
          case char do
            char when char in ["[", "{"] ->
              {acc, cur <> char, depth + 1}

            char when char in ["]", "}"] ->
              {acc, cur <> char, depth - 1}

            ^seperator when depth == 0 ->
              {acc ++ [cur], "", depth}

            char ->
              {acc, cur <> char, depth}
          end
        end
      )

    list ++ [last]
  end
end
