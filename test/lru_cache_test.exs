defmodule LRUCacheTest do
  use ExUnit.Case

  test "get returns value for existing key" do
    cache = LRUCache.new(3)
    cache = LRUCache.put(cache, :a, 1)
    assert LRUCache.get(cache, :a) == 1
  end

  test "get returns nil for missing key" do
    cache = LRUCache.new(3)
    assert LRUCache.get(cache, :a) == nil
  end

  test "put adds multiple keys" do
    cache = LRUCache.new(3)
    cache = cache |> LRUCache.put(:a, 1) |> LRUCache.put(:b, 2)
    assert LRUCache.get(cache, :a) == 1
    assert LRUCache.get(cache, :b) == 2
  end

  test "evicts least recently used when over capacity" do
    cache = LRUCache.new(3)

    cache =
      cache
      |> LRUCache.put(:a, 1)
      |> LRUCache.put(:b, 2)
      |> LRUCache.put(:c, 3)
      |> LRUCache.put(:d, 4)

    assert LRUCache.get(cache, :a) == nil
    assert LRUCache.get(cache, :d) == 4
  end

  test "get refreshes recency" do
    cache = LRUCache.new(3)

    cache =
      cache
      |> LRUCache.put(:a, 1)
      |> LRUCache.put(:b, 2)
      |> LRUCache.put(:c, 3)

    cache = LRUCache.get_and_refresh(cache, :a)
    cache = LRUCache.put(cache, :d, 4)
    assert LRUCache.get(cache, :a) == 1
    assert LRUCache.get(cache, :b) == nil
  end
end
