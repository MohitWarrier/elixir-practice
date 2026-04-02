defmodule Stack do
  def new do
    []
  end

  def push(stack, value) do
    [value | stack]
  end

  def pop([]) do
    :empty
  end

  def pop([head | tail]) do
    {head, tail}
  end

  def peek([]) do
    :empty
  end

  def peek([head | _tail]) do
    head
  end

  def size(stack) do
    Enum.reduce(stack, 0, fn _x, acc -> acc + 1 end)
  end

  def to_list(stack) do
    stack
  end
end
