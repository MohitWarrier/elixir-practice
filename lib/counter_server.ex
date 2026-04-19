defmodule CounterServer do
  use GenServer

  # === Client API (functions you call from outside) ===

  # start_link/1 — starts the GenServer
  # opts is a keyword list: [initial: 0, name: :my_counter]
  def start_link(opts) do
  end

  def get(pid) do
  end

  def increment(pid) do
  end

  def decrement(pid) do
  end

  def crash(pid) do
  end

  # === Server Callbacks (handle incoming messages) ===

  def init(initial_count) do
  end

  # handle_call for :get

  # handle_cast for :increment, :decrement, :crash
end

defmodule CounterSupervisor do
  use Supervisor

  # start_link/1 — starts the supervisor
  def start_link(opts) do
  end

  # init/1 — defines which children to supervise
  def init(opts) do
  end
end