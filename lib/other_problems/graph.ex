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

  def neighbors(graph, node) do
    graph.adjacency_list
    |> Map.get(node, MapSet.new())
    |> MapSet.to_list()
  end
end
