defmodule ShoppingCart do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init(initial_state) do
    {:ok,  initial_state}
  end

  def items(pid) do
    GenServer.call(pid, :get)
  end

  def total(pid) do
    GenServer.call(pid, :total)
  end

  def handle_call(:total, _from, state) do
    total =
    Enum.reduce(state, 0, fn item, acc ->
      acc + Map.get(item, :price)
        * Map.get(item, :qty)
    end)

    {:reply, total, state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def add_item(pid, name, price) do
    GenServer.cast(pid, {:add, name, price})
  end

  def remove_item(pid, name) do
    GenServer.cast(pid,{:remove, name})
  end

  def clear(pid) do
    GenServer.cast(pid, :clear)
  end

  def handle_cast({:add, name, price}, state) do

    new_state =
      case Enum.find_index(state, fn item ->
        Map.get(item, :name) == name
      end) do

        nil -> state ++
          [%{name: name, price: price, qty: 1}]

        index -> List.update_at(state, index, fn item
          -> Map.update(item, :qty, 1, fn qty ->
              qty + 1
          end)
        end)

      end

      {:noreply, new_state}
  end

  def handle_cast({:remove, name}, state) do

    new_state =
    Enum.reduce(state, [], fn item, acc ->
        if Map.get(item, :name) == name do
          acc
        else
          acc ++ [item]
        end
    end)

    {:noreply, new_state}

  end

  def handle_cast(:clear, _state) do
    {:noreply, []}
  end

end
