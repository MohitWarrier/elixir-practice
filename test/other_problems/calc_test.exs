defmodule CalcTest do
  use ExUnit.Case

  test "plain number" do
    assert Calc.eval(5) == 5
  end

  test "add two numbers" do
    assert Calc.eval({:add, 2, 3}) == 5
  end

  test "subtract" do
    assert Calc.eval({:subtract, 10, 4}) == 6
  end

  test "multiply" do
    assert Calc.eval({:multiply, 3, 4}) == 12
  end

  test "divide" do
    assert Calc.eval({:divide, 10, 2}) == 5.0
  end

  test "nested add and multiply" do
    # (2 * 3) + 4 = 10
    assert Calc.eval({:add, {:multiply, 2, 3}, 4}) == 10
  end

  test "deeply nested" do
    # (10 - (2 + 3)) * 2 = 10
    assert Calc.eval({:multiply, {:subtract, 10, {:add, 2, 3}}, 2}) == 10
  end

  test "nested on both sides" do
    # (1 + 2) + (3 + 4) = 10
    assert Calc.eval({:add, {:add, 1, 2}, {:add, 3, 4}}) == 10
  end

  test "divide by zero" do
    assert Calc.eval({:divide, 5, 0}) == :error
  end

  test "negate" do
    assert Calc.eval({:negate, 5}) == -5
  end

  test "negate nested" do
    # -(3 + 2) = -5
    assert Calc.eval({:negate, {:add, 3, 2}}) == -5
  end
end
