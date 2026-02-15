# LeetCode Solutions in Elixir

LeetCode problems solved in Elixir.

## Structure

```
lib/
  elixir_leetcode/          # LeetCode solutions
    two_sum.ex
    valid_parentheses.ex
    merge_two_sorted_lists.ex
    ...
  other_problems/           # Other coding problems
    list_sum.ex
    password_validator.ex
    ...

test/
  elixir_leetcode/          # Tests for LeetCode solutions
  other_problems/           # Tests for other problems
```

## Usage

```bash
# Clone the repo
git clone <repo-url>
cd elixir_leetcode

# Install dependencies
mix deps.get

# Run all tests
mix test

# Run tests for a specific problem
mix test test/elixir_leetcode/two_sum_test.exs
```

## Example

```elixir
defmodule ElixirLeetcode.TwoSum do
  def two_sum(nums, target) do
    # Solution implementation
  end
end
```

```elixir
defmodule ElixirLeetcode.TwoSumTest do
  use ExUnit.Case, async: true
  import ElixirLeetcode.TwoSum

  test "basic case" do
    assert two_sum([2, 7, 11, 15], 9) == [0, 1]
  end
end
```
