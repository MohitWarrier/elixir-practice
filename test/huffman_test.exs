defmodule HuffmanTest do
  use ExUnit.Case

  # Huffman encoding compresses text by giving shorter codes to frequent characters
  # and longer codes to rare ones.

  test "frequency map counts characters correctly" do
    assert Huffman.frequencies("aabbc") == %{?a => 2, ?b => 2, ?c => 1}
  end

  test "encoding a string produces a bitstring" do
    {encoded, _tree} = Huffman.encode("aabbc")
    assert is_bitstring(encoded)
  end

  test "decoding restores the original string" do
    {encoded, tree} = Huffman.encode("aabbc")
    assert Huffman.decode(encoded, tree) == "aabbc"
  end

  test "encode and decode a longer string" do
    original = "hello huffman"
    {encoded, tree} = Huffman.encode(original)
    assert Huffman.decode(encoded, tree) == original
  end

  test "frequent characters get shorter codes" do
    # 'a' appears 5 times, 'b' appears once
    {_encoded, tree} = Huffman.encode("aaaaabbc")
    codes = Huffman.codes(tree)
    assert bit_size(codes[?a]) < bit_size(codes[?b])
  end

  test "encoded output is shorter than original in bits" do
    original = "aaaaabbbcc"
    {encoded, _tree} = Huffman.encode(original)
    original_bits = byte_size(original) * 8
    assert bit_size(encoded) < original_bits
  end
end
