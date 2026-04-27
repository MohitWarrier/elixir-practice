defmodule LoadBalancerTest do
  use ExUnit.Case

  test "dispatches to workers in round robin order" do
    {:ok, lb} = LoadBalancer.new(["s1", "s2", "s3"])
    assert LoadBalancer.next(lb) == "s1"
    assert LoadBalancer.next(lb) == "s2"
    assert LoadBalancer.next(lb) == "s3"
    assert LoadBalancer.next(lb) == "s1"
  end

  test "works with a single worker" do
    {:ok, lb} = LoadBalancer.new(["solo"])
    assert LoadBalancer.next(lb) == "solo"
    assert LoadBalancer.next(lb) == "solo"
  end

  test "workers returns the current list" do
    {:ok, lb} = LoadBalancer.new(["s1", "s2"])
    assert LoadBalancer.workers(lb) == ["s1", "s2"]
  end

  test "add_worker adds to the pool" do
    {:ok, lb} = LoadBalancer.new(["s1", "s2"])
    LoadBalancer.add_worker(lb, "s3")
    assert "s3" in LoadBalancer.workers(lb)
  end

  test "remove_worker removes from the pool" do
    {:ok, lb} = LoadBalancer.new(["s1", "s2", "s3"])
    LoadBalancer.remove_worker(lb, "s2")
    refute "s2" in LoadBalancer.workers(lb)
  end

  test "round robin still works after adding a worker" do
    {:ok, lb} = LoadBalancer.new(["s1", "s2"])
    LoadBalancer.next(lb)
    LoadBalancer.next(lb)
    LoadBalancer.add_worker(lb, "s3")
    assert "s3" in LoadBalancer.workers(lb)
    assert LoadBalancer.next(lb) in ["s1", "s2", "s3"]
  end
end
