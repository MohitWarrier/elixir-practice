defmodule HttpCheckerTest do
  use ExUnit.Case

  test "check returns a map with url, status, and up keys" do
    result = HttpChecker.check("https://www.google.com")
    assert Map.has_key?(result, :url)
    assert Map.has_key?(result, :status)
    assert Map.has_key?(result, :up)
  end

  test "check returns up: true for a real url" do
    result = HttpChecker.check("https://www.google.com")
    assert result.up == true
  end

  test "check returns up: false for a bad url" do
    result = HttpChecker.check("https://this-url-does-not-exist-xyz.com")
    assert result.up == false
  end

  test "check_all returns a list of results" do
    results =
      HttpChecker.check_all(["https://www.google.com", "https://this-url-does-not-exist-xyz.com"])

    assert length(results) == 2
    assert Enum.all?(results, fn r -> Map.has_key?(r, :up) end)
  end
end
