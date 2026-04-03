defmodule RateLimiterTest do
  use ExUnit.Case

  test "allows events within limit" do
    rl = RateLimiter.new(3, 1000)
    {result, rl} = RateLimiter.check(rl, 100)
    assert result == :allow
    {result, rl} = RateLimiter.check(rl, 200)
    assert result == :allow
    {result, _rl} = RateLimiter.check(rl, 300)
    assert result == :allow
  end

  test "rejects events over limit" do
    rl = RateLimiter.new(2, 1000)
    {_, rl} = RateLimiter.check(rl, 100)
    {_, rl} = RateLimiter.check(rl, 200)
    {result, _rl} = RateLimiter.check(rl, 300)
    assert result == :reject
  end

  test "allows again after window expires" do
    rl = RateLimiter.new(2, 1000)
    {_, rl} = RateLimiter.check(rl, 100)
    {_, rl} = RateLimiter.check(rl, 200)
    {result, rl} = RateLimiter.check(rl, 300)
    assert result == :reject
    # after window passes
    {result, _rl} = RateLimiter.check(rl, 1200)
    assert result == :allow
  end

  test "sliding window removes old events" do
    rl = RateLimiter.new(2, 1000)
    {_, rl} = RateLimiter.check(rl, 100)
    {_, rl} = RateLimiter.check(rl, 500)
    # at time 1200, the event at 100 is outside the window
    {result, _rl} = RateLimiter.check(rl, 1200)
    assert result == :allow
  end

  test "one per window" do
    rl = RateLimiter.new(1, 500)
    {result, rl} = RateLimiter.check(rl, 0)
    assert result == :allow
    {result, rl} = RateLimiter.check(rl, 100)
    assert result == :reject
    {result, _rl} = RateLimiter.check(rl, 600)
    assert result == :allow
  end
end
