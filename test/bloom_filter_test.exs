defmodule BloomFilterTest do
  use ExUnit.Case

  test "new returns a bloom filter" do
    bf = BloomFilter.new()
    assert is_struct(bf, BloomFilter)
  end

  test "member? returns false for empty filter" do
    bf = BloomFilter.new()
    assert BloomFilter.member?(bf, "hello") == false
  end

  test "member? returns true after adding item" do
    bf = BloomFilter.new() |> BloomFilter.add("hello")
    assert BloomFilter.member?(bf, "hello") == true
  end

  test "member? returns false for item not added" do
    bf = BloomFilter.new() |> BloomFilter.add("hello")
    assert BloomFilter.member?(bf, "world") == false
  end

  test "multiple items can be added" do
    bf =
      BloomFilter.new()
      |> BloomFilter.add("cat")
      |> BloomFilter.add("dog")
      |> BloomFilter.add("fish")

    assert BloomFilter.member?(bf, "cat") == true
    assert BloomFilter.member?(bf, "dog") == true
    assert BloomFilter.member?(bf, "fish") == true
  end

  test "item not added is not a member" do
    bf =
      BloomFilter.new()
      |> BloomFilter.add("cat")
      |> BloomFilter.add("dog")

    assert BloomFilter.member?(bf, "fish") == false
  end
end
