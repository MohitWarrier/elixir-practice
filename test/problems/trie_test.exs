defmodule TrieTest do
  use ExUnit.Case

  test "new returns empty trie" do
    assert Trie.new() == %{}
  end

  test "insert one word" do
    trie = Trie.new() |> Trie.insert("cat")
    assert Trie.search(trie, "cat") == true
  end

  test "search returns false for missing word" do
    trie = Trie.new() |> Trie.insert("cat")
    assert Trie.search(trie, "car") == false
  end

  test "search returns false for prefix only" do
    trie = Trie.new() |> Trie.insert("cat")
    assert Trie.search(trie, "ca") == false
  end

  test "insert multiple words" do
    trie =
      Trie.new()
      |> Trie.insert("cat")
      |> Trie.insert("car")
      |> Trie.insert("card")

    assert Trie.search(trie, "cat") == true
    assert Trie.search(trie, "car") == true
    assert Trie.search(trie, "card") == true
  end

  test "starts_with returns true for matching prefix" do
    trie = Trie.new() |> Trie.insert("cat")
    assert Trie.starts_with(trie, "ca") == true
  end

  test "starts_with returns true for full word" do
    trie = Trie.new() |> Trie.insert("cat")
    assert Trie.starts_with(trie, "cat") == true
  end

  test "starts_with returns false for non-matching prefix" do
    trie = Trie.new() |> Trie.insert("cat")
    assert Trie.starts_with(trie, "dog") == false
  end

  test "starts_with works across multiple words" do
    trie =
      Trie.new()
      |> Trie.insert("cat")
      |> Trie.insert("car")
      |> Trie.insert("card")

    assert Trie.starts_with(trie, "car") == true
    assert Trie.starts_with(trie, "ca") == true
    assert Trie.starts_with(trie, "do") == false
  end
end
