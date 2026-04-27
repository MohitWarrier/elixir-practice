defmodule EtsStoreTest do
  use ExUnit.Case

  test "put and get a value" do
    t = EtsStore.new()
    EtsStore.put(t, :name, "Alice")
    assert EtsStore.get(t, :name) == {:ok, "Alice"}
  end

  test "get a missing key returns :not_found" do
    t = EtsStore.new()
    assert EtsStore.get(t, :missing) == :not_found
  end

  test "overwriting a key replaces the value" do
    t = EtsStore.new()
    EtsStore.put(t, :x, 1)
    EtsStore.put(t, :x, 2)
    assert EtsStore.get(t, :x) == {:ok, 2}
  end

  test "delete removes a key" do
    t = EtsStore.new()
    EtsStore.put(t, :y, 99)
    EtsStore.delete(t, :y)
    assert EtsStore.get(t, :y) == :not_found
  end

  test "all returns all key-value pairs as a map" do
    t = EtsStore.new()
    EtsStore.put(t, :a, 1)
    EtsStore.put(t, :b, 2)
    EtsStore.put(t, :c, 3)
    assert EtsStore.all(t) == %{a: 1, b: 2, c: 3}
  end
end
