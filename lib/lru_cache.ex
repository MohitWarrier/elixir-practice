defmodule LRUCache do
  def new(max_size) do
    %{max_size: max_size, cache: %{}, order: []}
  end

  def put(cache, key, val) do
    if cache.max_size > map_size(cache.cache) or Map.has_key?(cache.cache, key) do
      cache =
        Map.update(cache, :cache, %{}, fn x ->
          Map.update(x, key, val, fn _ev -> val end)
        end)

      Map.update(cache, :order, [], fn x ->
        if key not in x do
          [key | x]
        else
          x
        end
      end)
    else
      lru = hd(Enum.reverse(cache.order))
      new_order = [key | List.delete(cache.order, lru)]

      new_cache =
        Map.get(cache, :cache)
        |> Map.delete(lru)
        |> Map.update(key, val, fn _ev -> val end)

      cache = Map.put(cache, :cache, new_cache)
      cache = Map.put(cache, :order, new_order)

      cache
    end
  end

  def get(cache, key) do
    Map.get(cache, :cache, %{})
    |> Map.get(key)
  end

  def get_and_refresh(cache, key) do
    new_order = [key | List.delete(cache.order, key)]
    Map.put(cache, :order, new_order)
  end
end
