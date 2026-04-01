defmodule StackTest do
  use ExUnit.Case

  test "new stack is empty" do
    stack = Stack.new()
    assert Stack.size(stack) == 0
    assert Stack.peek(stack) == :empty
    assert Stack.pop(stack) == :empty
  end

  test "push and peek" do
    stack = Stack.new() |> Stack.push(1) |> Stack.push(2)
    assert Stack.peek(stack) == 2
  end

  test "push and pop" do
    stack = Stack.new() |> Stack.push(1) |> Stack.push(2)
    {val, stack} = Stack.pop(stack)
    assert val == 2
    {val, stack} = Stack.pop(stack)
    assert val == 1
    assert Stack.pop(stack) == :empty
  end

  test "size tracks correctly" do
    stack = Stack.new() |> Stack.push(:a) |> Stack.push(:b) |> Stack.push(:c)
    assert Stack.size(stack) == 3
    {_, stack} = Stack.pop(stack)
    assert Stack.size(stack) == 2
  end

  test "to_list returns top-first order" do
    stack = Stack.new() |> Stack.push(1) |> Stack.push(2) |> Stack.push(3)
    assert Stack.to_list(stack) == [3, 2, 1]
  end
end
