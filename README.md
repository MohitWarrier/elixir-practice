# LeetCode Training in Elixir

Daily LeetCode problem solving practice using Elixir.

## Structure

```
lib/
  elixir_leetcode/          # LeetCode problems
    two_sum.ex
    valid_parentheses.ex
    merge_two_sorted_lists.ex
    ...
  other_problems/           # Other coding challenges
    list_sum.ex
    password_validator.ex
    ...

test/
  elixir_leetcode/          # LeetCode tests
    two_sum_test.exs
    ...
  other_problems/           # Other tests
    list_sum_test.exs
    ...
```

## Usage

### Writing a Solution

Each problem is a module under `ElixirLeetcode`:

```elixir
defmodule ElixirLeetcode.TwoSum do
  @doc """
  Given an array of integers `nums` and an integer `target`, return the indices
  of the two numbers such that they add up to `target`.
  """
  def two_sum(nums, target) do
    # Your solution here
  end
end
```

### Writing Tests

Each test file corresponds to a problem:

```elixir
defmodule ElixirLeetcode.TwoSumTest do
  use ExUnit.Case, async: true
  import ElixirLeetcode.TwoSum

  test "basic case" do
    assert two_sum([2, 7, 11, 15], 9) == [0, 1]
  end

  test "same number used twice" do
    assert two_sum([3, 3], 6) == [0, 1]
  end
end
```

### Running Tests

```bash
# Run all tests
mix test

# Run tests for a specific problem
mix test test/elixir_leetcode/two_sum_test.exs

# Run tests in watch mode (if you have mix_test_watch installed)
mix test.watch
```

### Running the Formatter

```bash
mix format
```

## Installation

```bash
# Clone the repository
git clone <your-repo-url>
cd elixir_leetcode

# Install dependencies
mix deps.get

# Run tests
mix test
```

## Development Setup

### Using Visual Studio Code

1. [Install Docker Desktop](https://www.docker.com/products/docker-desktop)
1. Open project directory in VS Code
1. Press F1, and select `Remote-Containers: Reopen in Container...`
1. Wait as it builds the Dev Container Docker image
1. Once complete, VS Code will connect to your running Dev Container
1. To use a specific version of Elixir, change the `VARIANT` in `.devcontainer/devcontainer.json`

### Using GitHub Codespaces

1. On GitHub, navigate to the repository
1. Click the Code dropdown menu, and select "Open with Codespaces"
1. Click "New codespace" if you don't have one already

## Goals

- Solve one LeetCode problem per day
- Practice functional programming patterns in Elixir
- Build test-driven development habits
- Learn Elixir standard library deeply

## Progress

Track your progress by checking completed problems in `lib/elixir_leetcode/`.
