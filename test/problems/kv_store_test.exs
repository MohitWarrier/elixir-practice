defmodule KVStoreTest do
  use ExUnit.Case

  test "new store is empty" do
    store = KVStore.new()
    assert KVStore.get(store, "name") == nil
  end

  test "put and get" do
    store = KVStore.new() |> KVStore.put("name", "alice")
    assert KVStore.get(store, "name") == "alice"
  end

  test "overwrite value" do
    store =
      KVStore.new()
      |> KVStore.put("name", "alice")
      |> KVStore.put("name", "bob")

    assert KVStore.get(store, "name") == "bob"
  end

  test "get_at returns value at specific time" do
    store =
      KVStore.new()
      |> KVStore.put("name", "alice")
      |> KVStore.put("name", "bob")
      |> KVStore.put("name", "charlie")

    assert KVStore.get_at(store, "name", 1) == "alice"
    assert KVStore.get_at(store, "name", 2) == "bob"
    assert KVStore.get_at(store, "name", 3) == "charlie"
  end

  test "get_at returns nil for time before first put" do
    store = KVStore.new() |> KVStore.put("name", "alice")
    assert KVStore.get_at(store, "name", 0) == nil
  end

  test "get_at returns latest value at that time" do
    store =
      KVStore.new()
      |> KVStore.put("x", "a")
      |> KVStore.put("y", "b")
      |> KVStore.put("x", "c")

    assert KVStore.get_at(store, "x", 1) == "a"
    assert KVStore.get_at(store, "x", 2) == "a"
    assert KVStore.get_at(store, "x", 3) == "c"
  end

  test "multiple keys" do
    store =
      KVStore.new()
      |> KVStore.put("a", 1)
      |> KVStore.put("b", 2)

    assert KVStore.get(store, "a") == 1
    assert KVStore.get(store, "b") == 2
  end

  test "delete key" do
    store =
      KVStore.new()
      |> KVStore.put("name", "alice")
      |> KVStore.delete("name")

    assert KVStore.get(store, "name") == nil
  end
end
