defmodule AgentStack do
  def new() do
    Agent.start_link(fn -> [] end)
  end

  def push(stack, value) do
    Agent.update(stack, fn state -> [value | state] end)
  end

  def pop(stack) do
    case empty?(stack) do
      false -> Agent.get_and_update(stack, fn state -> {hd(state), tl(state)} end)
      true -> nil
    end
  end

  def peek(stack) do
    Agent.get(stack, fn state -> hd(state) end)
  end

  def empty?(stack) do
    Agent.get(stack, fn state -> state == [] end)
  end

  def size(stack) do
    Agent.get(stack, fn state -> length(state) end)
  end
end
