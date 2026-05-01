defmodule QueryBuilder do
  defstruct table: nil, columns: [], wheres: [], limit: nil, order: nil

  # new/1 — creates a new query for the given table
  def new(table) do
    %QueryBuilder{table: table, columns: [], wheres: [], limit: nil, order: nil}
  end

  # select/2 — sets which columns to return (list of strings)
  def select(%QueryBuilder{} = q, columns) do
    %QueryBuilder{q | columns: columns}
  end

  # where/2 — adds a condition string, multiple calls are joined with AND
  def where(%QueryBuilder{} = q, condition) do
    %QueryBuilder{q | wheres: q.wheres ++ [condition]}
  end

  # limit/2 — sets the max number of rows to return
  def limit(%QueryBuilder{} = q, n) do
    %QueryBuilder{q | limit: n}
  end

  # order_by/2 and order_by/3 — sets the ORDER BY column and optional direction (:asc or :desc)
  def order_by(%QueryBuilder{} = q, column, direction \\ :asc) do
    %QueryBuilder{q | order: {column, direction}}
  end

  # to_sql/1 — builds and returns the final SQL string
  # clause order: SELECT ... FROM ... WHERE ... ORDER BY ... LIMIT ...
  def to_sql(%QueryBuilder{} = q) do
    [
      "SELECT " <>
        case q.columns do
          [] -> "*"
          cols -> Enum.join(cols, ", ")
        end,
      "FROM " <> q.table,
      case q.wheres do
        [] -> nil
        conditions -> "WHERE " <> Enum.join(conditions, " AND ")
      end,
      case q.order do
        nil -> nil
        {col, :asc} -> "ORDER BY " <> col
        {col, :desc} -> "ORDER BY " <> col <> " DESC"
      end,
      case q.limit do
        nil -> nil
        limit -> "LIMIT " <> Integer.to_string(limit)
      end
    ]
    |> Enum.reject(fn element -> is_nil(element) end)
    |> Enum.join(" ")
  end
end
