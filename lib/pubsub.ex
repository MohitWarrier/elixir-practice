defmodule PubSub do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  def subscribe(pid, topic) do
    GenServer.call(pid, {:subscribe, topic})
  end

  def unsubscribe(pid, topic) do
    GenServer.call(pid, {:unsubscribe, topic})
  end

  def handle_call({:subscribe, topic}, {caller, _ref}, state) do
    new_state =
      case Enum.member?(Map.get(state, topic, []), caller) do
        false ->
          Map.update(state, topic, [caller], fn x ->
            x ++ [caller]
          end)

        true ->
          state
      end

    {:reply, :ok, new_state}
  end

  def handle_call({:unsubscribe, topic}, {caller, _ref}, state) do
    new_list =
      Map.get(state, topic, [])
      |> List.delete(caller)

    new_state =
      if new_list == [] do
        Map.delete(state, topic)
      else
        Map.put(state, topic, new_list)
      end

    {:reply, :ok, new_state}
  end

  def handle_call(:topics, _from, state) do
    {:reply, Map.keys(state), state}
  end

  def publish(pid, topic, message) do
    GenServer.cast(pid, {:publish, topic, message})
  end

  def handle_cast({:publish, topic, message}, state) do
    Map.get(state, topic, [])
    |> Enum.each(fn x ->
      send(x, {:pubsub, topic, message})
    end)

    {:noreply, state}
  end

  def topics(pid) do
    GenServer.call(pid, :topics)
  end
end
