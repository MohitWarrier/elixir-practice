defmodule Middleware do
  # run/2 — passes ctx through each middleware function in order
  # each middleware is a fn(ctx) -> ctx | {:halt, ctx}
  # if a middleware returns {:halt, ctx}, stop and return ctx immediately

  def run(ctx, []) do
    ctx
  end

  def run(ctx, [mw | rest]) do
    case mw.(ctx) do
      {:halt, new_ctx} -> new_ctx
      new_ctx -> run(new_ctx, rest)
    end
  end

end
