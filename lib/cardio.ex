defmodule Cardio do
  # ─── Warm-up ───────────────────────────────────────────────────────────────

  # Return the length of a list WITHOUT using Enum.count/length.
  # my_length([1, 2, 3])  => 3
  # my_length([])         => 0
  def my_length(list) do
    Enum.reduce(list, 0, fn _x, acc -> acc + 1 end)
  end

  # Return the last element of a list.
  # last([1, 2, 3])  => 3
  # last([42])       => 42
  def last(_list), do: nil

  # Double every element in a list.
  # double([1, 2, 3])  => [2, 4, 6]
  # double([])         => []
  def double(_list), do: nil

  # Return true if all elements in the list are even.
  # all_even?([2, 4, 6])  => true
  # all_even?([2, 3, 6])  => false
  # all_even?([])         => true
  def all_even?(_list), do: nil

  # Concatenate two lists WITHOUT using ++.
  # my_concat([1, 2], [3, 4])  => [1, 2, 3, 4]
  # my_concat([], [1])         => [1]
  def my_concat(_a, _b), do: nil

  # ─── Easy ──────────────────────────────────────────────────────────────────

  # Sum all numbers in a list.
  # sum([1, 2, 3, 4])   => 10
  # sum([])             => 0
  # sum([-1, 0.5, 2.5]) => 2.0
  def sum(_list), do: nil

  # Remove duplicates, preserving first occurrence order.
  # unique([1, 2, 1, 3, 2])    => [1, 2, 3]
  # unique(["a", "b", "a"])    => ["a", "b"]
  # unique([])                 => []
  def unique(_list), do: nil

  # Flatten a nested list (any depth).
  # flatten([1, [2, [3, 4]], 5])  => [1, 2, 3, 4, 5]
  # flatten([])                   => []
  def flatten(_list), do: nil

  # Return every nth element (1-indexed).
  # every_nth([1, 2, 3, 4, 5, 6], 2)  => [2, 4, 6]
  # every_nth([1, 2, 3, 4, 5], 3)     => [3]  (only index 3, not 6)
  # every_nth([], 2)                   => []
  def every_nth(_list, _n), do: nil

  # Return a map of each element to how many times it appears.
  # frequency(["a", "b", "a", "c", "b", "a"])  => %{"a" => 3, "b" => 2, "c" => 1}
  # frequency([])                               => %{}
  def frequency(_list), do: nil

  # Zip two lists into a list of {a, b} tuples. Stop at the shorter list.
  # my_zip([1, 2, 3], [:a, :b, :c])  => [{1, :a}, {2, :b}, {3, :c}]
  # my_zip([1, 2], [:a])             => [{1, :a}]
  # my_zip([], [1, 2])               => []
  def my_zip(_a, _b), do: nil

  # Rotate a list left by n positions.
  # rotate([1, 2, 3, 4, 5], 2)  => [3, 4, 5, 1, 2]
  # rotate([1, 2, 3], 0)        => [1, 2, 3]
  # rotate([], 3)               => []
  def rotate(_list, _n), do: nil

  # ─── Medium ────────────────────────────────────────────────────────────────

  # Split a list into chunks of size n. Last chunk may be smaller.
  # chunk([1, 2, 3, 4, 5], 2)  => [[1, 2], [3, 4], [5]]
  # chunk([1, 2, 3, 4], 3)     => [[1, 2, 3], [4]]
  # chunk([], 3)               => []
  def chunk(_list, _n), do: nil

  # Partition a list into {passing, failing} based on a predicate.
  # partition([1, -2, 3, -4], fn n -> n > 0 end)  => {[1, 3], [-2, -4]}
  # partition([], fn _ -> true end)               => {[], []}
  def partition(_list, _pred), do: nil

  # Return cumulative running totals.
  # running_total([1, 2, 3, 4])   => [1, 3, 6, 10]
  # running_total([5])            => [5]
  # running_total([])             => []
  def running_total(_list), do: nil

  # Group a list of maps by the value of a given key.
  # group_by([%{role: "admin", name: "Alice"}, %{role: "user", name: "Bob"}, %{role: "admin", name: "Carol"}], :role)
  # => %{"admin" => [%{role: "admin", name: "Alice"}, %{role: "admin", name: "Carol"}], "user" => [%{role: "user", name: "Bob"}]}
  def group_by(_list, _key), do: nil

  # Return the top n items from a list using a scoring function (highest first).
  # top_n([3, 1, 4, 1, 5, 9, 2], 3, fn x -> x end)  => [9, 5, 4]
  # top_n(["cat", "elephant", "ox"], 2, &String.length/1)  => ["elephant", "cat"]
  def top_n(_list, _n, _score_fn), do: nil

  # Interleave two lists, alternating elements. Append leftover from longer list.
  # interleave([1, 2, 3], [:a, :b, :c])    => [1, :a, 2, :b, 3, :c]
  # interleave([1, 2, 3], [:a])            => [1, :a, 2, 3]
  # interleave([], [1, 2])                 => [1, 2]
  def interleave(_a, _b), do: nil

  # Apply a function to each element and return only the non-nil results.
  # filter_map([1, 2, 3, 4], fn x -> if rem(x, 2) == 0, do: x * 10 end)  => [20, 40]
  # filter_map([], fn x -> x end)                                          => []
  def filter_map(_list, _fun), do: nil

  # Sliding window: return all consecutive sublists of size n.
  # windows([1, 2, 3, 4, 5], 3)  => [[1, 2, 3], [2, 3, 4], [3, 4, 5]]
  # windows([1, 2], 3)           => []
  # windows([], 2)               => []
  def windows(_list, _n), do: nil

  # Deep map: apply a function to every non-list element in a nested list.
  # deep_map([1, [2, [3]], 4], fn x -> x * 2 end)  => [2, [4, [6]], 8]
  def deep_map(_list, _fun), do: nil

  # ─── Hard ──────────────────────────────────────────────────────────────────

  # Run-length encode a list.
  # encode([1, 1, 2, 3, 3, 3])         => [{1, 2}, {2, 1}, {3, 3}]  (value, count)
  # encode(["a", "a", "b"])            => [{"a", 2}, {"b", 1}]
  # encode([])                         => []
  def encode(_list), do: nil

  # Run-length decode (inverse of encode).
  # decode([{1, 2}, {2, 1}, {3, 3}])   => [1, 1, 2, 3, 3, 3]
  # decode([])                         => []
  def decode(_list), do: nil

  # Return all permutations of a list.
  # permutations([1, 2, 3])  => [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]] (any order)
  # permutations([])         => [[]]
  def permutations(_list), do: nil

  # Return the powerset (all subsets) of a list.
  # powerset([1, 2])  => [[], [1], [2], [1, 2]] (any order)
  # powerset([])      => [[]]
  def powerset(_list), do: nil

  # Cartesian product of two lists.
  # product([1, 2], [:a, :b])  => [{1, :a}, {1, :b}, {2, :a}, {2, :b}]
  # product([], [1, 2])        => []
  def product(_a, _b), do: nil

  # Given a list of {word, doc_id} pairs, build an inverted index.
  # inverted_index([{"cat", "doc1"}, {"dog", "doc1"}, {"cat", "doc2"}])
  # => %{"cat" => ["doc1", "doc2"], "dog" => ["doc1"]}
  def inverted_index(_pairs), do: nil

  # Merge a list of maps. Later maps win on key conflicts.
  # deep_merge([%{a: 1, b: 2}, %{b: 3, c: 4}])  => %{a: 1, b: 3, c: 4}
  # deep_merge([])                               => %{}
  def deep_merge(_maps), do: nil

  # Given a list of {from, to} edges, return the nodes reachable from start (BFS).
  # reachable([{"a", "b"}, {"b", "c"}, {"a", "d"}], "a")  => ["a", "b", "d", "c"] (BFS order)
  # reachable([], "a")                                     => ["a"]
  def reachable(_edges, _start), do: nil
end
