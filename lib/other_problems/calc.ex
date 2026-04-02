defmodule Calc do

  def eval(num) when is_number(num) do
    num
  end

  def eval({:add, a,b}) do
    eval(a) + eval(b)
  end

   def eval({:subtract, a,b}) do
    eval(a) - eval(b)
  end

  def eval({:multiply, a, b}) do
    eval(a) * eval(b)
  end

   def eval({:divide, _a,0}) do
    :error
  end

   def eval({:divide, a,b}) do
    eval(a) / eval(b)
  end

   def eval({:negate, a}) do
    -eval(a)
  end

end
