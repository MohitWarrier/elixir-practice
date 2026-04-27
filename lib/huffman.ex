defmodule Huffman do

  # frequencies/1 — count how often each character appears
  # "aabbc" → %{?a => 2, ?b => 2, ?c => 1}
  def frequencies(string) do
  end

  # build_tree/1 — build a Huffman tree from a frequency map
  # returns a nested tuple tree: {freq, left, right} or {freq, char}
  def build_tree(freqs) do
  end

  # codes/1 — walk the tree and assign a bitstring code to each character
  # left branch = 0, right branch = 1
  # returns %{char => <<bits>>}
  def codes(tree) do
  end

  # encode/1 — convert a string to a compressed bitstring using Huffman codes
  # returns {encoded_bitstring, tree}
  def encode(string) do
  end

  # decode/2 — walk the tree using the bits to recover the original string
  def decode(bits, tree) do
  end

end
