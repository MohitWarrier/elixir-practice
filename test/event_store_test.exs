defmodule EventStoreTest do
  use ExUnit.Case

  # EventStore models a bank account using event sourcing.
  # State is never stored directly — it's derived by replaying events.

  test "new store has empty history" do
    store = EventStore.new()
    assert EventStore.history(store) == []
  end

  test "replaying an empty store returns initial state" do
    store = EventStore.new()
    assert EventStore.replay(store) == %{balance: 0}
  end

  test "append adds event to history" do
    store = EventStore.new() |> EventStore.append({:deposit, 100})
    assert EventStore.history(store) == [{:deposit, 100}]
  end

  test "deposit increases balance" do
    store = EventStore.new() |> EventStore.append({:deposit, 100})
    assert EventStore.replay(store) == %{balance: 100}
  end

  test "multiple deposits accumulate" do
    store =
      EventStore.new()
      |> EventStore.append({:deposit, 100})
      |> EventStore.append({:deposit, 50})

    assert EventStore.replay(store) == %{balance: 150}
  end

  test "withdraw decreases balance" do
    store =
      EventStore.new()
      |> EventStore.append({:deposit, 100})
      |> EventStore.append({:withdraw, 30})

    assert EventStore.replay(store) == %{balance: 70}
  end

  test "replay is order-dependent (balance can go negative)" do
    store =
      EventStore.new()
      |> EventStore.append({:deposit, 100})
      |> EventStore.append({:withdraw, 200})

    assert EventStore.replay(store) == %{balance: -100}
  end

  test "history returns events in insertion order" do
    store =
      EventStore.new()
      |> EventStore.append({:deposit, 100})
      |> EventStore.append({:withdraw, 30})
      |> EventStore.append({:deposit, 50})

    assert EventStore.history(store) == [
             {:deposit, 100},
             {:withdraw, 30},
             {:deposit, 50}
           ]
  end

  # replay_at/2 — replay only the first n events (time travel)
  test "replay_at replays only first n events" do
    store =
      EventStore.new()
      |> EventStore.append({:deposit, 100})
      |> EventStore.append({:withdraw, 30})
      |> EventStore.append({:deposit, 50})

    # after 1 event: deposit 100
    assert EventStore.replay_at(store, 1) == %{balance: 100}
    # after 2 events: deposit 100, withdraw 30
    assert EventStore.replay_at(store, 2) == %{balance: 70}
    # after all 3: deposit 100, withdraw 30, deposit 50
    assert EventStore.replay_at(store, 3) == %{balance: 120}
  end
end