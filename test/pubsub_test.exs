defmodule PubSubTest do
  use ExUnit.Case

  test "starts with no topics" do
    {:ok, ps} = PubSub.start_link()
    assert PubSub.topics(ps) == []
  end

  test "subscribe creates a topic" do
    {:ok, ps} = PubSub.start_link()
    PubSub.subscribe(ps, "sports")
    assert PubSub.topics(ps) == ["sports"]
  end

  test "publish sends message to subscriber" do
    {:ok, ps} = PubSub.start_link()
    PubSub.subscribe(ps, "sports")
    PubSub.publish(ps, "sports", "Goal!")

    assert_receive {:pubsub, "sports", "Goal!"}
  end

  test "publish does not send to unsubscribed" do
    {:ok, ps} = PubSub.start_link()
    PubSub.subscribe(ps, "sports")
    PubSub.publish(ps, "news", "Breaking!")

    refute_receive {:pubsub, "news", "Breaking!"}
  end

  test "multiple subscribers receive message" do
    {:ok, ps} = PubSub.start_link()

    # spawn a second subscriber
    test_pid = self()

    child =
      spawn(fn ->
        PubSub.subscribe(ps, "sports")
        send(test_pid, :subscribed)

        receive do
          msg -> send(test_pid, {:child_got, msg})
        end
      end)

    # wait for child to subscribe
    assert_receive :subscribed

    PubSub.subscribe(ps, "sports")
    PubSub.publish(ps, "sports", "Goal!")

    assert_receive {:pubsub, "sports", "Goal!"}
    assert_receive {:child_got, {:pubsub, "sports", "Goal!"}}
  end

  test "unsubscribe stops messages" do
    {:ok, ps} = PubSub.start_link()
    PubSub.subscribe(ps, "sports")
    PubSub.unsubscribe(ps, "sports")
    PubSub.publish(ps, "sports", "Goal!")

    refute_receive {:pubsub, "sports", "Goal!"}
  end

  test "topic removed when no subscribers" do
    {:ok, ps} = PubSub.start_link()
    PubSub.subscribe(ps, "sports")
    PubSub.unsubscribe(ps, "sports")
    assert PubSub.topics(ps) == []
  end
end
