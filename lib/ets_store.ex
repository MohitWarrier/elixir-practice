defmodule EtsStore do
  # new/0 — creates a new ETS table, returns a reference you use for all other calls
  # hint: :ets.new(:ets_store, [:set, :public])
  def new() do
    :ets.new(:ets_store, [:set, :public])
  end

  # put/3 — inserts a key-value pair into the table
  # hint: :ets.insert(table, {key, value})
  def put(table, key, value) do
    :ets.insert(table, {key, value})
  end

  # get/2 — returns {:ok, value} if found, :not_found if not
  # hint: :ets.lookup(table, key) returns [{key, value}] or []
  def get(table, key) do
    case :ets.lookup(table, key) do
      [] -> :not_found
      [{^key, value}] -> {:ok, value}
    end
  end

  # delete/2 — removes a key from the table
  # hint: :ets.delete(table, key)
  def delete(table, key) do
    :ets.delete(table, key)
  end

  # all/1 — returns all entries as a map %{key => value}
  # hint: :ets.tab2list(table) returns [{key, value}, ...]
  def all(table) do
    :ets.tab2list(table)
    |> Map.new()
  end
end
