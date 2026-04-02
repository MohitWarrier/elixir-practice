defmodule CounterTest do
  use ExUnit.Case

  test "start with initial value" do
    pid = Counter.start(0)
    assert is_pid(pid)
    assert Counter.get(pid) == 0
  end

  test "increment" do
    pid = Counter.start(0)
    Counter.increment(pid)
    assert Counter.get(pid) == 1
  end

  test "increment multiple times" do
    pid = Counter.start(0)
    Counter.increment(pid)
    Counter.increment(pid)
    Counter.increment(pid)
    assert Counter.get(pid) == 3
  end

  test "decrement" do
    pid = Counter.start(10)
    Counter.decrement(pid)
    assert Counter.get(pid) == 9
  end

  test "start with custom value" do
    pid = Counter.start(100)
    assert Counter.get(pid) == 100
  end

  test "mix of operations" do
    pid = Counter.start(5)
    Counter.increment(pid)
    Counter.increment(pid)
    Counter.decrement(pid)
    assert Counter.get(pid) == 6
  end
end
