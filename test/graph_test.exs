defmodule GraphTest do
  use ExUnit.Case

  #
  #  Graph used in most tests (undirected):
  #
  #  1 -- 2 -- 4
  #  |
  #  3 -- 5
  #

  def sample_graph() do
    Graph.new()
    |> Graph.add_edge(1, 2)
    |> Graph.add_edge(1, 3)
    |> Graph.add_edge(2, 4)
    |> Graph.add_edge(3, 5)
  end

  test "new graph has no neighbors" do
    g = Graph.new()
    assert Graph.neighbors(g, 1) == []
  end

  test "add_edge adds both directions" do
    g = Graph.new() |> Graph.add_edge(1, 2)
    assert Graph.neighbors(g, 1) == [2]
    assert Graph.neighbors(g, 2) == [1]
  end

  test "self-loop is ignored" do
    g = Graph.new() |> Graph.add_edge(1, 1)
    assert Graph.neighbors(g, 1) == []
  end

  test "bfs finds direct neighbor" do
    g = sample_graph()
    assert Graph.bfs(g, 1, 2) == [1, 2]
  end

  test "bfs finds shortest path across multiple hops" do
    g = sample_graph()
    assert Graph.bfs(g, 1, 4) == [1, 2, 4]
  end

  test "bfs returns nil when no path exists" do
    g = Graph.new() |> Graph.add_edge(1, 2) |> Graph.add_edge(3, 4)
    assert Graph.bfs(g, 1, 4) == nil
  end

  test "bfs from node to itself returns just that node" do
    g = sample_graph()
    assert Graph.bfs(g, 1, 1) == [1]
  end

  test "bfs handles cycles without infinite loop" do
    g =
      Graph.new()
      |> Graph.add_edge(1, 2)
      |> Graph.add_edge(2, 3)
      |> Graph.add_edge(3, 1)

    result = Graph.bfs(g, 1, 3)
    assert result != nil
    assert hd(result) == 1
    assert List.last(result) == 3
  end
end
