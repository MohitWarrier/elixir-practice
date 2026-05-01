defmodule BloomFilter do
  import Bitwise
  defstruct bits: 0, size: 256

  def new() do
    %BloomFilter{}
  end

  def add(%BloomFilter{} = bf, elem) do
    pos = :erlang.phash2(elem, bf.size)
    new_bits = bor(bf.bits, 1 <<< pos)
    %BloomFilter{bf | bits: new_bits}
  end

  def member?(%BloomFilter{} = bf, elem) do
    pos = :erlang.phash2(elem, bf.size)
    band(bf.bits, 1 <<< pos) != 0
  end
end
