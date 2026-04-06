defmodule CaesarTest do
  use ExUnit.Case

  test "encrypt basic" do
    assert Caesar.encrypt("hello", 3) == "khoor"
  end

  test "encrypt wraps around" do
    assert Caesar.encrypt("xyz", 2) == "zab"
  end

  test "encrypt preserves case" do
    assert Caesar.encrypt("Hello", 1) == "Ifmmp"
  end

  test "encrypt keeps non-letters" do
    assert Caesar.encrypt("hello, world!", 5) == "mjqqt, btwqi!"
  end

  test "decrypt reverses encrypt" do
    assert Caesar.decrypt("khoor", 3) == "hello"
  end

  test "encrypt with shift 0" do
    assert Caesar.encrypt("hello", 0) == "hello"
  end

  test "encrypt with shift 26 is same" do
    assert Caesar.encrypt("hello", 26) == "hello"
  end
end
