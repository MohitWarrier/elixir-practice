# ===== Step 1: Shape behaviour =====
# A behaviour defines callbacks — functions that any module using this behaviour MUST implement.

defmodule Shape do
  @callback area(map()) :: number()
  @callback perimeter(map()) :: number()
end

# ===== Step 2: Circle =====

defmodule Circle do
  defstruct [:radius]
  @behaviour Shape

  def area(%Circle{} = c) do
    :math.pi() * c.radius ** 2
  end

  def perimeter(%Circle{} = c) do
    2 * :math.pi() * c.radius
  end
end

# ===== Step 3: Rectangle =====

defmodule Rectangle do
  defstruct [:width, :height]
  @behaviour Shape

  def area(%Rectangle{} = r) do
    r.width * r.height
  end

  def perimeter(%Rectangle{} = r) do
    2 * (r.width + r.height)
  end
end

# ===== Step 4: Describable protocol =====
# A protocol defines a function that different data TYPES can implement differently.

defprotocol Describable do
  def describe(value)
end

# ===== Step 5: Implement Describable for each type =====

defimpl Describable, for: Circle do
  def describe(%Circle{} = c) do
    "Circle with radius #{c.radius}"
  end
end

defimpl Describable, for: Rectangle do
  def describe(%Rectangle{} = r) do
    "Rectangle #{r.width}x#{r.height}"
  end
end

defimpl Describable, for: Integer do
  def describe(n) do
    "The number #{n}"
  end
end
