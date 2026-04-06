defmodule CsvParser do

  def parse(csv_string) do
    csv = csv_string |> String.trim() |> String.split()
    headers = String.split(hd(csv), ",")
    data = tl(csv)
    Enum.map(data, fn row ->
      values = String.split(row, ",")
      Enum.zip(headers, values)
      |> Enum.into(%{})
    end)

  end

  def column(rows, col_name) do
    Enum.map(rows, fn row ->
      Map.get(row, col_name)
    end)
  end

  def where(rows, col_name, value) do

    Enum.filter(rows, fn row ->
      row[col_name] == value
    end)

  end

  def sort_by(rows, col_name) do

    Enum.sort_by(rows, fn row ->
      row[col_name]
    end, :asc)

  end

  def unique(rows, col_name) do
    Enum.uniq(column(rows, col_name))
  end

  def count_by(rows, col_name) do
    column(rows, col_name)
    |> Enum.reduce(%{}, fn val, acc ->
      Map.update(acc, val, 1, fn existing_val ->
        existing_val + 1
      end)
    end)
  end

end
