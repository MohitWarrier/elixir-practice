defmodule TaskQueue do
  def run_all(list) do
    tasks = Enum.map(list, fn x -> Task.async(x) end)
    Enum.map(tasks, fn task -> Task.await(task) end)
  end

  def run_all(list, timeout) do
    tasks = Enum.map(list, fn x -> Task.async(x) end)

    Enum.map(tasks, fn task ->
      try do
        Task.await(task, timeout)
      catch
        :exit, _ -> :timeout
      end
    end)
  end
end
