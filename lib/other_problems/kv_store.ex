defmodule KVStore do

  def new() do
    %{:count => 0}
  end


  def put(map, key, value) do

    new_count = Map.get(map, :count) + 1

    map
    |> Map.update(key, [{new_count,value}], fn existing_list ->
        [{new_count,value} | existing_list]
    end)
    |> Map.put(:count, new_count)

  end

  def get(map, key) do
    case Map.get(map,key) do

      nil -> :nil
      list -> elem(hd(list),1)

    end

  end

  def get_at(map, key, time) when time <= map.count and time > 0 do

    case Map.get(map, key) do

      nil -> :nil

      list -> list
        |> Enum.reduce_while(0, fn {t,val}, _acc ->
          IO.inspect({t,val})
          cond do
            time == t -> {:halt, val}
            time > t -> {:halt, val}
            time < t -> {:cont, :nil}
          end
        end)

    end
  end

  def get_at(_map, _key, _time) do
    :nil
  end

  def delete(map, key) do
    Map.delete(map, key)
  end

end
