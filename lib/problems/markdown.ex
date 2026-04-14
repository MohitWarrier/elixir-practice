defmodule Markdown do
  def to_html(string) do
    string
    |> String.split("\n")
    |> Enum.chunk_by(fn line -> String.starts_with?(line, "- ") end)
    |> Enum.map(fn group -> convert_group(group) end)
    |> Enum.join()
  end

  def convert_group(group) do
    case String.starts_with?(hd(group), "- ") do
      true ->
        res =
          Enum.map(group, fn line -> convert_line(line) end)
          |> Enum.join()

        "<ul>" <> res <> "</ul>"

      false ->
        Enum.map(group, fn line -> convert_line(line) end)
        |> Enum.join()
    end
  end

  def convert_line(line) do
    case line do
      "###" <> rest -> "<h3>" <> apply_inline(rest) <> "</h3>"
      "##" <> rest -> "<h2>" <> apply_inline(rest) <> "</h2>"
      "#" <> rest -> "<h1>" <> apply_inline(rest) <> "</h1>"
      "- " <> rest -> "<li>" <> apply_inline(rest) <> "</li>"
      plain -> "<p>" <> apply_inline(plain) <> "</p>"
    end
  end

  def apply_inline(line) do
    String.trim(line)
    |> String.replace(~r/\*\*(.+?)\*\*/, "<strong>\\1</strong>")
    |> String.replace(~r/\*(.+?)\*/, "<em>\\1</em>")
  end
end
