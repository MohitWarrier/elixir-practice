defmodule AgentStackTest do
  use ExUnit.Case

  test "new stack is empty" do
    {:ok, stack} = AgentStack.new()
    assert AgentStack.empty?(stack) == true
  end

  test "push adds an element" do
    {:ok, stack} = AgentStack.new()
    AgentStack.push(stack, 1)
    assert AgentStack.empty?(stack) == false
  end

  test "peek returns the top element without removing it" do
    {:ok, stack} = AgentStack.new()
    AgentStack.push(stack, 10)
    AgentStack.push(stack, 20)
    assert AgentStack.peek(stack) == 20
    assert AgentStack.size(stack) == 2
  end

  test "pop removes and returns the top element" do
    {:ok, stack} = AgentStack.new()
    AgentStack.push(stack, 1)
    AgentStack.push(stack, 2)
    assert AgentStack.pop(stack) == 2
    assert AgentStack.size(stack) == 1
  end

  test "pop returns nil on empty stack" do
    {:ok, stack} = AgentStack.new()
    assert AgentStack.pop(stack) == nil
  end

  test "size returns number of elements" do
    {:ok, stack} = AgentStack.new()
    AgentStack.push(stack, :a)
    AgentStack.push(stack, :b)
    AgentStack.push(stack, :c)
    assert AgentStack.size(stack) == 3
  end

  test "lifo order" do
    {:ok, stack} = AgentStack.new()
    AgentStack.push(stack, 1)
    AgentStack.push(stack, 2)
    AgentStack.push(stack, 3)
    assert AgentStack.pop(stack) == 3
    assert AgentStack.pop(stack) == 2
    assert AgentStack.pop(stack) == 1
  end
end
