defmodule TaskQueueTest do
  use ExUnit.Case

  test "run_all returns results of all functions" do
    results = TaskQueue.run_all([
      fn -> 1 + 1 end,
      fn -> 2 + 2 end,
      fn -> 3 + 3 end
    ])
    assert results == [2, 4, 6]
  end

  test "run_all runs tasks concurrently" do
    start = System.monotonic_time(:millisecond)
    TaskQueue.run_all([
      fn -> Process.sleep(100); 1 end,
      fn -> Process.sleep(100); 2 end,
      fn -> Process.sleep(100); 3 end
    ])
    elapsed = System.monotonic_time(:millisecond) - start
    assert elapsed < 200
  end

  test "run_all with timeout returns :timeout for slow tasks" do
    results = TaskQueue.run_all([
      fn -> 1 + 1 end,
      fn -> Process.sleep(5000); 99 end
    ], 200)
    assert results == [2, :timeout]
  end

  test "run_all with timeout returns all results when fast enough" do
    results = TaskQueue.run_all([
      fn -> 1 + 1 end,
      fn -> 2 + 2 end
    ], 1000)
    assert results == [2, 4]
  end
end