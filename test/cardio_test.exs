defmodule CardioTest do
  use ExUnit.Case, async: true

  # ─── Warm-up ───────────────────────────────────────────────────────────────

  describe "my_length" do
    test "counts elements" do
      assert Cardio.my_length([1, 2, 3]) == 3
      assert Cardio.my_length([]) == 0
      assert Cardio.my_length([:a, :b]) == 2
    end
  end

  describe "last" do
    test "returns last element" do
      assert Cardio.last([1, 2, 3]) == 3
      assert Cardio.last([42]) == 42
      assert Cardio.last([:a, :b, :c]) == :c
    end
  end

  describe "double" do
    test "doubles every element" do
      assert Cardio.double([1, 2, 3]) == [2, 4, 6]
      assert Cardio.double([]) == []
      assert Cardio.double([0, -1]) == [0, -2]
    end
  end

  describe "all_even?" do
    test "returns true when all even" do
      assert Cardio.all_even?([2, 4, 6]) == true
      assert Cardio.all_even?([]) == true
    end

    test "returns false when any odd" do
      assert Cardio.all_even?([2, 3, 6]) == false
      assert Cardio.all_even?([1]) == false
    end
  end

  describe "my_concat" do
    test "joins two lists" do
      assert Cardio.my_concat([1, 2], [3, 4]) == [1, 2, 3, 4]
      assert Cardio.my_concat([], [1]) == [1]
      assert Cardio.my_concat([1], []) == [1]
      assert Cardio.my_concat([], []) == []
    end
  end

  # ─── Easy ──────────────────────────────────────────────────────────────────

  describe "sum" do
    test "sums a list of numbers" do
      assert Cardio.sum([1, 2, 3, 4]) == 10
      assert Cardio.sum([]) == 0
      assert Cardio.sum([7]) == 7
      assert Cardio.sum([-1, 0.5, 2.5]) == 2.0
    end
  end

  describe "unique" do
    test "removes duplicates preserving first occurrence" do
      assert Cardio.unique([1, 2, 1, 3, 2]) == [1, 2, 3]
      assert Cardio.unique(["a", "b", "a"]) == ["a", "b"]
      assert Cardio.unique([]) == []
    end
  end

  describe "flatten" do
    test "flattens nested lists" do
      assert Cardio.flatten([1, [2, [3, 4]], 5]) == [1, 2, 3, 4, 5]
      assert Cardio.flatten([]) == []
      assert Cardio.flatten([[1], [2], [3]]) == [1, 2, 3]
      assert Cardio.flatten([1, [2, [3, [4]]]]) == [1, 2, 3, 4]
    end
  end

  describe "every_nth" do
    test "returns every nth element (1-indexed)" do
      assert Cardio.every_nth([1, 2, 3, 4, 5, 6], 2) == [2, 4, 6]
      assert Cardio.every_nth([1, 2, 3, 4, 5], 3) == [3]
      assert Cardio.every_nth([], 2) == []
      assert Cardio.every_nth([1, 2, 3], 1) == [1, 2, 3]
    end
  end

  describe "frequency" do
    test "returns a count map" do
      assert Cardio.frequency(["a", "b", "a", "c", "b", "a"]) == %{"a" => 3, "b" => 2, "c" => 1}
      assert Cardio.frequency([]) == %{}
      assert Cardio.frequency([1, 1, 1]) == %{1 => 3}
    end
  end

  describe "my_zip" do
    test "zips two lists into tuples, stops at shorter" do
      assert Cardio.my_zip([1, 2, 3], [:a, :b, :c]) == [{1, :a}, {2, :b}, {3, :c}]
      assert Cardio.my_zip([1, 2], [:a]) == [{1, :a}]
      assert Cardio.my_zip([], [1, 2]) == []
    end
  end

  describe "rotate" do
    test "rotates list left by n" do
      assert Cardio.rotate([1, 2, 3, 4, 5], 2) == [3, 4, 5, 1, 2]
      assert Cardio.rotate([1, 2, 3], 0) == [1, 2, 3]
      assert Cardio.rotate([], 3) == []
      assert Cardio.rotate([1, 2, 3], 3) == [1, 2, 3]
    end
  end

  # ─── Medium ────────────────────────────────────────────────────────────────

  describe "chunk" do
    test "splits into consecutive chunks" do
      assert Cardio.chunk([1, 2, 3, 4, 5], 2) == [[1, 2], [3, 4], [5]]
      assert Cardio.chunk([1, 2, 3, 4], 3) == [[1, 2, 3], [4]]
      assert Cardio.chunk([], 3) == []
      assert Cardio.chunk(["a"], 5) == [["a"]]
    end
  end

  describe "partition" do
    test "splits into passing and failing" do
      assert Cardio.partition([1, -2, 3, -4], fn n -> n > 0 end) == {[1, 3], [-2, -4]}
      assert Cardio.partition([], fn _ -> true end) == {[], []}
      assert Cardio.partition([1, 2, 3], fn n -> n > 10 end) == {[], [1, 2, 3]}
    end
  end

  describe "running_total" do
    test "returns cumulative sums" do
      assert Cardio.running_total([1, 2, 3, 4]) == [1, 3, 6, 10]
      assert Cardio.running_total([5]) == [5]
      assert Cardio.running_total([]) == []
      assert Cardio.running_total([1, -2, 3]) == [1, -1, 2]
    end
  end

  describe "group_by" do
    test "groups maps by key value" do
      input = [
        %{role: "admin", name: "Alice"},
        %{role: "user", name: "Bob"},
        %{role: "admin", name: "Carol"}
      ]

      result = Cardio.group_by(input, :role)
      assert result["admin"] == [%{role: "admin", name: "Alice"}, %{role: "admin", name: "Carol"}]
      assert result["user"] == [%{role: "user", name: "Bob"}]
    end

    test "returns empty map for empty list" do
      assert Cardio.group_by([], :role) == %{}
    end
  end

  describe "top_n" do
    test "returns top n items by score, highest first" do
      assert Cardio.top_n([3, 1, 4, 1, 5, 9, 2], 3, fn x -> x end) == [9, 5, 4]
      assert Cardio.top_n(["cat", "elephant", "ox"], 2, &String.length/1) == ["elephant", "cat"]
      assert Cardio.top_n([1, 2, 3], 0, fn x -> x end) == []
    end
  end

  describe "interleave" do
    test "alternates elements, appends leftover" do
      assert Cardio.interleave([1, 2, 3], [:a, :b, :c]) == [1, :a, 2, :b, 3, :c]
      assert Cardio.interleave([1, 2, 3], [:a]) == [1, :a, 2, 3]
      assert Cardio.interleave([], [1, 2]) == [1, 2]
    end
  end

  describe "filter_map" do
    test "keeps only non-nil results of fun" do
      assert Cardio.filter_map([1, 2, 3, 4], fn x -> if rem(x, 2) == 0, do: x * 10 end) == [20, 40]
      assert Cardio.filter_map([], fn x -> x end) == []
      assert Cardio.filter_map([1, 2, 3], fn _ -> nil end) == []
    end
  end

  describe "windows" do
    test "returns all consecutive sublists of size n" do
      assert Cardio.windows([1, 2, 3, 4, 5], 3) == [[1, 2, 3], [2, 3, 4], [3, 4, 5]]
      assert Cardio.windows([1, 2], 3) == []
      assert Cardio.windows([], 2) == []
      assert Cardio.windows([1, 2, 3], 1) == [[1], [2], [3]]
    end
  end

  describe "deep_map" do
    test "applies fun to every non-list element recursively" do
      assert Cardio.deep_map([1, [2, [3]], 4], fn x -> x * 2 end) == [2, [4, [6]], 8]
      assert Cardio.deep_map([], fn x -> x end) == []
      assert Cardio.deep_map([1, 2, 3], fn x -> x + 1 end) == [2, 3, 4]
    end
  end

  # ─── Hard ──────────────────────────────────────────────────────────────────

  describe "encode (run-length)" do
    test "encodes consecutive runs as {value, count}" do
      assert Cardio.encode([1, 1, 2, 3, 3, 3]) == [{1, 2}, {2, 1}, {3, 3}]
      assert Cardio.encode(["a", "a", "b"]) == [{"a", 2}, {"b", 1}]
      assert Cardio.encode([]) == []
      assert Cardio.encode([1]) == [{1, 1}]
    end
  end

  describe "decode (run-length)" do
    test "expands {value, count} tuples back to list" do
      assert Cardio.decode([{1, 2}, {2, 1}, {3, 3}]) == [1, 1, 2, 3, 3, 3]
      assert Cardio.decode([]) == []
      assert Cardio.decode([{"a", 3}]) == ["a", "a", "a"]
    end
  end

  describe "permutations" do
    test "returns all orderings" do
      result = Cardio.permutations([1, 2, 3])
      assert length(result) == 6
      assert Enum.sort(result) == Enum.sort([[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]])
      assert Cardio.permutations([]) == [[]]
    end
  end

  describe "powerset" do
    test "returns all subsets" do
      result = Cardio.powerset([1, 2])
      assert length(result) == 4
      assert [] in result
      assert [1] in result
      assert [2] in result
      assert [1, 2] in result
      assert Cardio.powerset([]) == [[]]
    end
  end

  describe "product" do
    test "returns cartesian product" do
      assert Cardio.product([1, 2], [:a, :b]) == [{1, :a}, {1, :b}, {2, :a}, {2, :b}]
      assert Cardio.product([], [1, 2]) == []
      assert Cardio.product([1], [:x]) == [{1, :x}]
    end
  end

  describe "inverted_index" do
    test "maps words to list of doc ids" do
      pairs = [{"cat", "doc1"}, {"dog", "doc1"}, {"cat", "doc2"}]
      result = Cardio.inverted_index(pairs)
      assert result["cat"] == ["doc1", "doc2"]
      assert result["dog"] == ["doc1"]
      assert Cardio.inverted_index([]) == %{}
    end
  end

  describe "deep_merge" do
    test "merges list of maps, later keys win" do
      assert Cardio.deep_merge([%{a: 1, b: 2}, %{b: 3, c: 4}]) == %{a: 1, b: 3, c: 4}
      assert Cardio.deep_merge([]) == %{}
      assert Cardio.deep_merge([%{x: 1}]) == %{x: 1}
    end
  end

  describe "reachable" do
    test "returns nodes reachable from start via BFS" do
      edges = [{"a", "b"}, {"b", "c"}, {"a", "d"}]
      result = Cardio.reachable(edges, "a")
      assert hd(result) == "a"
      assert Enum.sort(result) == Enum.sort(["a", "b", "c", "d"])
      assert Cardio.reachable([], "a") == ["a"]
    end
  end
end
