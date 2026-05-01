defmodule LazyStreams do
  require Integer

  # first_n_evens/1 — return the first n even numbers
  # hint: Stream.iterate(start, fn x -> ... end)
  def first_n_evens(n) do
    Stream.iterate(2, fn x -> x + 2 end)
    |> Enum.take(n)
  end

  # first_n_squares/1 — return the first n perfect squares (1, 4, 9, 16, ...)
  # hint: Stream.iterate then Stream.map
  def first_n_squares(n) do
    Stream.iterate(1, fn x -> x + 1 end)
    |> Stream.map(fn x -> x ** 2 end)
    |> Enum.take(n)
  end

  # running_sum/1 — each element is the sum of all elements up to that point
  # [1, 2, 3, 4, 5] → [1, 3, 6, 10, 15]
  # hint: Stream.scan
  def running_sum(list) do
    Stream.scan(list, 0, fn acc, x -> acc + x end)
    |> Enum.to_list()
  end

  # cycle_labels/2 — repeat the labels list infinitely, take first n
  # cycle_labels(["a","b","c"], 7) → ["a","b","c","a","b","c","a"]
  # hint: Stream.cycle
  def cycle_labels(labels, n) do
    Stream.cycle(labels)
    |> Enum.take(n)
  end

  # fibonacci/1 — return first n fibonacci numbers
  # hint: Stream.unfold({a, b}, fn {a, b} -> {emit, next_state} end)
  def fibonacci(n) do
    Stream.unfold({0, 1}, fn {a, b} ->
      {a, {b, a + b}}
    end)
    |> Enum.take(n)
  end
end
