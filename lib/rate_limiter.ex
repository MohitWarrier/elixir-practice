defmodule RateLimiter do
  def new(max_events, window_ms) do
    %{max_events: max_events, window_ms: window_ms, events: []}
  end

  def check(rate_limiter, timestamp) do
    new_list =
      remove_old_events(rate_limiter, timestamp)

    rate_limiter =
      Map.put(rate_limiter, :events, new_list)

    count = length(rate_limiter.events)

    if count < rate_limiter.max_events do
      new_list = rate_limiter.events ++ [timestamp]
      updated_rl = Map.put(rate_limiter, :events, new_list)
      {:allow, updated_rl}
    else
      {:reject, rate_limiter}
    end
  end

  defp remove_old_events(rl, ts) do
    events = rl.events

    Enum.reduce(events, [], fn event, acc ->
      if event >= ts - rl.window_ms do
        acc ++ [event]
      else
        acc
      end
    end)
  end
end
