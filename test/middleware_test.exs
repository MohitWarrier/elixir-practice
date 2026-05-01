defmodule MiddlewareTest do
  use ExUnit.Case

  # A middleware pipeline passes a "context" map through a list of functions.
  # Each middleware can read and modify the context, then pass it along.
  # This is how Plug (Phoenix's HTTP middleware) works under the hood.

  test "empty pipeline returns context unchanged" do
    ctx = %{status: 200, body: "hello"}
    result = Middleware.run(ctx, [])
    assert result == %{status: 200, body: "hello"}
  end

  test "single middleware can modify context" do
    add_header = fn ctx -> Map.put(ctx, :x_powered_by, "Elixir") end

    result = Middleware.run(%{}, [add_header])
    assert result == %{x_powered_by: "Elixir"}
  end

  test "middlewares run in order" do
    first  = fn ctx -> Map.put(ctx, :log, ["first"]) end
    second = fn ctx -> Map.update(ctx, :log, [], &(&1 ++ ["second"])) end
    third  = fn ctx -> Map.update(ctx, :log, [], &(&1 ++ ["third"])) end

    result = Middleware.run(%{}, [first, second, third])
    assert result.log == ["first", "second", "third"]
  end

  test "each middleware receives the context modified by previous ones" do
    double = fn ctx -> Map.update(ctx, :value, 0, &(&1 * 2)) end

    result = Middleware.run(%{value: 3}, [double, double, double])
    assert result.value == 24
  end

  test "middleware can halt the pipeline early" do
    # if a middleware returns {:halt, ctx}, no further middlewares run
    halt_mw  = fn ctx -> {:halt, Map.put(ctx, :halted, true)} end
    after_mw = fn ctx -> Map.put(ctx, :should_not_run, true) end

    result = Middleware.run(%{}, [halt_mw, after_mw])
    assert result.halted == true
    refute Map.has_key?(result, :should_not_run)
  end

  test "pipeline continues normally if no halt" do
    normal = fn ctx -> Map.put(ctx, :ran, true) end
    result = Middleware.run(%{}, [normal])
    assert result.ran == true
  end
end
