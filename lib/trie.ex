defmodule Trie do
  def new() do
    %{}
  end

  def insert(trie, word) do
    insert_letters(trie, String.graphemes(word))
  end

  def insert_letters(trie, []) do
    Map.put(trie, :end, true)
  end

  def insert_letters(trie, [head|tail]) do
      child = Map.get(trie, head, %{})
      Map.put(trie, head, insert_letters(child, tail))
  end

  def search(trie, word) do
    search_letters(trie, String.graphemes(word))
  end

  def search_letters(trie, []) do
    case trie do
      %{end: _} -> true
      _ -> false
    end
  end

  def search_letters(trie, [head|tail]) do
     Map.get(trie, head, %{})
     |> search_letters(tail)
  end

  def starts_with(trie, word) do
    path(trie, String.graphemes(word))
  end

  def path(_trie, []) do
    true
  end

  def path(trie, [head|tail]) do
    case Map.get(trie, head) do

      :nil -> false
      map -> path(map, tail)
    end

  end
end
