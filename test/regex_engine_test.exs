defmodule RegexEngineTest do
  use ExUnit.Case

  # Literal matching
  test "matches single literal character" do
    assert RegexEngine.match?("a", "a") == true
  end

  test "does not match wrong literal" do
    assert RegexEngine.match?("a", "b") == false
  end

  test "matches multiple literals" do
    assert RegexEngine.match?("ab", "ab") == true
  end

  test "does not match partial literal" do
    assert RegexEngine.match?("ab", "ac") == false
  end

  # Dot matching
  test "dot matches any character" do
    assert RegexEngine.match?(".", "a") == true
    assert RegexEngine.match?(".", "z") == true
  end

  test "dot in pattern matches any char in string" do
    assert RegexEngine.match?(".b", "ab") == true
    assert RegexEngine.match?(".b", "cb") == true
  end

  # Star matching
  test "star matches zero occurrences" do
    assert RegexEngine.match?("a*", "") == true
  end

  test "star matches multiple occurrences" do
    assert RegexEngine.match?("a*", "aaa") == true
  end

  test "star with following literal" do
    assert RegexEngine.match?("a*b", "aaab") == true
    assert RegexEngine.match?("a*b", "b") == true
  end

  test "dot star matches anything" do
    assert RegexEngine.match?(".*", "anything") == true
    assert RegexEngine.match?(".*", "") == true
  end

  # Combined
  test "complex pattern" do
    assert RegexEngine.match?("a.*b", "axyzb") == true
    assert RegexEngine.match?("a.*b", "ab") == true
  end
end
