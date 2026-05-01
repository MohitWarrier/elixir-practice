defmodule CounterServer do
  use GenServer

  # === Client API (functions you call from outside) ===

  # start_link/1 — starts the GenServer
  # opts is a keyword list: [initial: 0, name: :my_counter]
  def start_link(opts) do
    initial = Keyword.get(opts, :initial, 0)
    name = Keyword.get(opts, :name)
    GenServer.start_link(__MODULE__, initial, name: name)
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def increment(pid) do
    GenServer.cast(pid, :increment)
  end

  def decrement(pid) do
    GenServer.cast(pid, :decrement)
  end

  def crash(pid) do
    GenServer.cast(pid, :crash)
  end

  # === Server Callbacks (handle incoming messages) ===

  def init(initial_count) do
    {:ok, initial_count}
  end

  # handle_call for :get
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  # handle_cast for :increment, :decrement, :crash
  def handle_cast(:increment, state) do
    {:noreply, state + 1}
  end

  def handle_cast(:decrement, state) do
    {:noreply, state - 1}
  end

  def handle_cast(:crash, _state) do
    raise("BOOM")
  end
end

defmodule CounterSupervisor do
  use Supervisor

  # start_link/1 — starts the supervisor
  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts)
  end

  # init/1 — defines which children to supervise
  def init(opts) do
    children = [
      {CounterServer, opts}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
