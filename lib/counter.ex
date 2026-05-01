defmodule Counter do
  def start(initial_value) do
    pid = spawn(fn -> loop(initial_value) end)
    pid
  end

  def increment(pid) do
    send(pid, :increment)
  end

  def decrement(pid) do
    send(pid, :decrement)
  end

  def get(pid) do
    send(pid, {:get, self()})

    receive do
      {:reply, value} ->
        value
    end
  end

  defp loop(value) do
    receive do
      :increment ->
        loop(value + 1)

      :decrement ->
        loop(value - 1)

      {:get, caller} ->
        send(caller, {:reply, value})
        loop(value)
    end
  end
end
