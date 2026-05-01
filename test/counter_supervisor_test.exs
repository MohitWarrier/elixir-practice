defmodule CounterSupervisorTest do
  use ExUnit.Case

  # ===== Part 1: CounterServer (GenServer) =====

  test "starts with initial value 0" do
    {:ok, pid} = CounterServer.start_link(initial: 0)
    assert CounterServer.get(pid) == 0
  end

  test "starts with custom initial value" do
    {:ok, pid} = CounterServer.start_link(initial: 10)
    assert CounterServer.get(pid) == 10
  end

  test "increment increases count by 1" do
    {:ok, pid} = CounterServer.start_link(initial: 0)
    CounterServer.increment(pid)
    assert CounterServer.get(pid) == 1
  end

  test "decrement decreases count by 1" do
    {:ok, pid} = CounterServer.start_link(initial: 5)
    CounterServer.decrement(pid)
    assert CounterServer.get(pid) == 4
  end

  test "multiple operations" do
    {:ok, pid} = CounterServer.start_link(initial: 0)
    CounterServer.increment(pid)
    CounterServer.increment(pid)
    CounterServer.increment(pid)
    CounterServer.decrement(pid)
    assert CounterServer.get(pid) == 2
  end

  # ===== Part 2: CounterSupervisor =====

  test "supervisor starts the counter server" do
    {:ok, sup} = CounterSupervisor.start_link(initial: 0, name: :sup_test)
    assert CounterServer.get(:sup_test) == 0
    Supervisor.stop(sup)
  end

  test "counter restarts with fresh state after crash" do
    {:ok, sup} = CounterSupervisor.start_link(initial: 0, name: :crash_test)

    # increment to 5
    CounterServer.increment(:crash_test)
    CounterServer.increment(:crash_test)
    CounterServer.increment(:crash_test)
    CounterServer.increment(:crash_test)
    CounterServer.increment(:crash_test)
    assert CounterServer.get(:crash_test) == 5

    # save the pid before crash
    old_pid = GenServer.whereis(:crash_test)

    # crash the counter
    CounterServer.crash(:crash_test)

    # wait for supervisor to restart it
    Process.sleep(50)

    # it's a brand new process — different pid
    new_pid = GenServer.whereis(:crash_test)
    assert old_pid != new_pid

    # state is back to 0 — the old state (5) is gone
    assert CounterServer.get(:crash_test) == 0

    Supervisor.stop(sup)
  end
end
