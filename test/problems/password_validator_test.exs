defmodule OtherProblems.PasswordValidatorTest do
  use ExUnit.Case, async: true

  import OtherProblems.PasswordValidator

  @tag :skip
  test "part1: empty input" do
    input = ""
    assert part1(input) == 0
  end

  @tag :skip
  test "part1: single line" do
    input = "5\n"
    assert part1(input) == 0
  end

  @tag :skip
  test "part1: simple example" do
    input = """
    1
    3
    2
    5
    6
    1
    """

    assert part1(input) == 3
  end

  @tag :skip
  test "part1: all increasing" do
    input = """
    1
    2
    3
    4
    """

    assert part1(input) == 3
  end

  @tag :skip
  test "part1: all equal" do
    input = """
    5
    5
    5
    """

    assert part1(input) == 0
  end

  @tag :skip
  test "part2: empty input" do
    input = ""
    assert part2(input) == 0
  end

  @tag :skip
  test "part2: example from description" do
    input = """
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
    """

    assert part2(input) == 1
  end

  test "part2: multiple valid and invalid" do
    input = """
    1-3 a: abcde
    1-3 a: xaxxx
    2-4 b: abbb
    2-4 b: axbx
    """

    assert part2(input) == 1
  end

  @tag :skip
  test "part2: position beyond password length" do
    input = """
    5-6 z: abc
    """

    # positions 5 and 6 don't exist -> neither matches -> invalid
    assert part2(input) == 0
  end
end
