defmodule Huffman do

  # frequencies/1 — count how often each character appears
  # "aabbc" → %{?a => 2, ?b => 2, ?c => 1}
  def frequencies(string) do
    Enum.frequencies(String.to_charlist(string))
  end

  # build_tree/1 — build a Huffman tree from a frequency map
  # returns a nested tuple tree: {freq, left, right} or {freq, char}
  def build_tree(freqs) do
    freqs
    |> Map.to_list()
    |> Enum.map(fn {k,v} -> {v,k} end)
    |> Enum.sort_by(fn {k,_v} -> k end)
    |> merge_loop()
  end

  def merge_loop([tree]) do
    tree
  end

  def merge_loop([a,b | rest]) do
    [{elem(a,0) + elem(b,0),a,b} | rest]
    |> Enum.sort_by(fn x -> elem(x,0) end)
    |> merge_loop()
  end


  # codes/1 — walk the tree and assign a bitstring code to each character
  # left branch = 0, right branch = 1
  # returns %{char => <<bits>>}
  def codes(tree) do
    walk(tree, <<>>)
  end

  def walk({_freq, char}, bits) do
    %{char => bits}
  end

  def walk({_freq, left, right}, bits) do
    Map.merge(walk(left, <<bits::bitstring, 0::1>>),
    walk(right, <<bits::bitstring, 1::1>>))
  end

  # encode/1 — convert a string to a compressed bitstring using Huffman codes
  # returns {encoded_bitstring, tree}
  def encode(string) do
    tree = frequencies(string)
    |> build_tree()
    codes = codes(tree)

    bit_string =
    string
    |> String.to_charlist()
    |> Enum.reduce(<<>>, fn char, acc ->
      <<acc::bitstring, codes[char]::bitstring>>
    end)

    {bit_string,tree}

  end

  # decode/2 — walk the tree using the bits to recover the original string
  def decode(bits, tree) do
    decode_helper(bits, tree, tree)
  end

  def decode_helper(<<>>, {_freq, char}, _root) do
    List.to_string([char])
  end

  def decode_helper(bits, {_freq, char}, root) do
    List.to_string([char]) <> decode_helper(bits, root, root)
  end

  def decode_helper(<<bit::1, rest::bitstring>>,
      {_freq, left, right}, root) do

        case bit do
          0 -> decode_helper(rest, left, root)
          1 -> decode_helper(rest, right, root)
        end

  end


end
