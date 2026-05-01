defmodule LoadBalancer do
  # new/1 — start an Agent holding the worker list and a current index
  # state: %{workers: [...], index: 0}
  def new(workers) do
    Agent.start_link(fn -> %{workers: workers, index: 0} end)
  end

  # next/1 — return the worker at the current index, then advance the index
  # when index reaches the end, it wraps back to 0
  # hint: Agent.get_and_update, rem/2 for wrapping
  def next(lb) do
    Agent.get_and_update(lb, fn %{workers: workers, index: index} = state ->
      {Enum.at(workers, index), Map.put(state, :index, rem(index + 1, length(workers)))}
    end)
  end

  # workers/1 — return the current list of workers
  def workers(lb) do
    Agent.get(lb, fn state -> Map.get(state, :workers, []) end)
  end

  # add_worker/2 — append a worker to the list
  def add_worker(lb, worker) do
    Agent.update(lb, fn state ->
      Map.update(state, :workers, [], fn workers -> workers ++ [worker] end)
    end)
  end

  # remove_worker/2 — remove a worker from the list, reset index to 0
  # hint: List.delete/2
  def remove_worker(lb, worker) do
    Agent.update(lb, fn state ->
      state
      |> Map.update(:workers, [], fn x -> List.delete(x, worker) end)
      |> Map.put(:index, 0)
    end)
  end
end
