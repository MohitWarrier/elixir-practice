defmodule EventStore do
  defstruct events: []

  # new/0 — returns an empty store
  def new() do
    %EventStore{events: []}
  end

  # append/2 — adds an event to the store, returns updated store
  def append(%EventStore{} = store, event) do
    %EventStore{store | events: store.events ++ [event]}
  end

  # history/1 — returns the list of all events in order
  def history(%EventStore{} = store) do
    store.events
  end

  # replay/1 — applies all events to the initial state, returns final state
  # initial state: %{balance: 0}
  def replay(%EventStore{} = store) do
    replayer(store.events)
  end

  # replay_at/2 — replay only the first n events
  def replay_at(%EventStore{} = store, n) do
    Enum.take(store.events, n)
    |> replayer()
  end

  defp replayer(events) do
    Enum.reduce(events, %{balance: 0}, fn event, acc ->

      case event do
        {:deposit, amount} -> %{acc | balance: acc.balance + amount}
        {:withdraw, amount} -> %{acc | balance: acc.balance - amount}
      end

    end)
  end

end
