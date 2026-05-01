defmodule ShapesTest do
  use ExUnit.Case

  # ===== Part 1: Shape behaviour =====
  # Circle and Rectangle both implement area/1 and perimeter/1

  test "circle area" do
    c = %Circle{radius: 5}
    assert Circle.area(c) == :math.pi() * 25
  end

  test "circle perimeter" do
    c = %Circle{radius: 5}
    assert Circle.perimeter(c) == 2 * :math.pi() * 5
  end

  test "rectangle area" do
    r = %Rectangle{width: 4, height: 6}
    assert Rectangle.area(r) == 24
  end

  test "rectangle perimeter" do
    r = %Rectangle{width: 4, height: 6}
    assert Rectangle.perimeter(r) == 20
  end

  # ===== Part 2: Describable protocol =====
  # Any type can implement describe/1

  test "describe a circle" do
    c = %Circle{radius: 5}
    assert Describable.describe(c) == "Circle with radius 5"
  end

  test "describe a rectangle" do
    r = %Rectangle{width: 4, height: 6}
    assert Describable.describe(r) == "Rectangle 4x6"
  end

  test "describe an integer" do
    assert Describable.describe(42) == "The number 42"
  end
end
