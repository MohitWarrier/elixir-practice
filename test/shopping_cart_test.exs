defmodule ShoppingCartTest do
  use ExUnit.Case

  test "starts with empty cart" do
    {:ok, pid} = ShoppingCart.start_link()
    assert ShoppingCart.items(pid) == []
  end

  test "add item to cart" do
    {:ok, pid} = ShoppingCart.start_link()
    ShoppingCart.add_item(pid, "apple", 1.50)
    assert ShoppingCart.items(pid) == [%{name: "apple", price: 1.50, qty: 1}]
  end

  test "add same item increases quantity" do
    {:ok, pid} = ShoppingCart.start_link()
    ShoppingCart.add_item(pid, "apple", 1.50)
    ShoppingCart.add_item(pid, "apple", 1.50)
    assert ShoppingCart.items(pid) == [%{name: "apple", price: 1.50, qty: 2}]
  end

  test "add multiple different items" do
    {:ok, pid} = ShoppingCart.start_link()
    ShoppingCart.add_item(pid, "apple", 1.50)
    ShoppingCart.add_item(pid, "bread", 2.00)
    items = ShoppingCart.items(pid)
    assert length(items) == 2
  end

  test "remove item from cart" do
    {:ok, pid} = ShoppingCart.start_link()
    ShoppingCart.add_item(pid, "apple", 1.50)
    ShoppingCart.add_item(pid, "bread", 2.00)
    ShoppingCart.remove_item(pid, "apple")
    items = ShoppingCart.items(pid)
    assert length(items) == 1
    assert hd(items).name == "bread"
  end

  test "total price" do
    {:ok, pid} = ShoppingCart.start_link()
    ShoppingCart.add_item(pid, "apple", 1.50)
    ShoppingCart.add_item(pid, "apple", 1.50)
    ShoppingCart.add_item(pid, "bread", 2.00)
    assert ShoppingCart.total(pid) == 5.00
  end

  test "clear cart" do
    {:ok, pid} = ShoppingCart.start_link()
    ShoppingCart.add_item(pid, "apple", 1.50)
    ShoppingCart.clear(pid)
    assert ShoppingCart.items(pid) == []
  end
end
