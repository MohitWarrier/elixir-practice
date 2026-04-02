defmodule Graph do
  defstruct adjacency_list: %{}

  def new() do
    %Graph{}
  end

  def add_edge(%Graph{} = graph, a, b) when a == b, do: graph

  def add_edge(%Graph{} = graph, a, b) when a != b do
    adj =
      graph.adjacency_list
      |> Map.update(a, MapSet.new([b]), fn neighbors -> MapSet.put(neighbors, b) end)
      |> Map.update(b, MapSet.new([a]), fn neighbors -> MapSet.put(neighbors, a) end)

    %Graph{graph | adjacency_list: adj}
  end

  def add_node(%Graph{} = graph, node) do
    adj = Map.put_new(graph.adjacency_list, node, MapSet.new())
    %Graph{graph | adjacency_list: adj}
  end

  def neighbors(graph, node) do
    graph.adjacency_list
    |> Map.get(node, MapSet.new())
    |> MapSet.to_list()
  end

  def bfs(graph, start, target) do
    # find shortest path from start to target
    # return path as a list e.g. [:a, :b, :c]
    # return nil if no path exists

    bfs_helper(graph, [start], MapSet.new([start]), %{}, target)
  end

  defp bfs_helper(graph, queue, visited, came_from, target) do
    case queue do
      [] ->
        nil

      [current | rest] ->
        if current == target do
          reconstruct_path(came_from, current)
        else
          neighbors = neighbors(graph, current)
          new_neighbors = Enum.filter(neighbors, fn n -> not MapSet.member?(visited, n) end)

          new_queue = rest ++ new_neighbors
          new_visited = Enum.reduce(new_neighbors, visited, fn n, acc -> MapSet.put(acc, n) end)

          new_came_from =
            Enum.reduce(new_neighbors, came_from, fn n, acc -> Map.put(acc, n, current) end)

          bfs_helper(graph, new_queue, new_visited, new_came_from, target)
        end
    end
  end

  defp reconstruct_path(came_from, current) do
    case Map.get(came_from, current) do
      nil -> [current]
      prev -> reconstruct_path(came_from, prev) ++ [current]
    end
  end
end
