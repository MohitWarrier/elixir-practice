defmodule RegexEngine do
  def match?(pattern, string) do
    checker(
      String.graphemes(pattern),
      String.graphemes(string)
    )
  end

  def checker([], []) do
    true
  end

  def checker([], _) do
    false
  end

  def checker([_, "*" | p_tail], []) do
    checker(p_tail, [])
  end

  def checker([p_head, "*" | p_tail], [s_head | s_tail]) do
    cond do
      p_head == s_head or p_head == "." ->
        checker([p_head, "*" | p_tail], s_tail)
        or checker(p_tail, [s_head |s_tail])
      true ->
        checker(p_tail, [s_head | s_tail])
    end
  end

  def checker(_, []) do
    false
  end

  def checker([p_head | p_tail], [s_head | s_tail]) do
    cond do
      p_head == s_head -> checker(p_tail, s_tail)
      p_head == "." -> checker(p_tail, s_tail)
      true -> false
    end
  end
end
