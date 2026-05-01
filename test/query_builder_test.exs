defmodule QueryBuilderTest do
  use ExUnit.Case

  # QueryBuilder builds SQL SELECT strings from a chain of function calls.
  # It does NOT connect to a database — it just produces SQL strings.

  test "select all from a table" do
    sql =
      QueryBuilder.new("users")
      |> QueryBuilder.to_sql()

    assert sql == "SELECT * FROM users"
  end

  test "select specific columns" do
    sql =
      QueryBuilder.new("users")
      |> QueryBuilder.select(["name", "email"])
      |> QueryBuilder.to_sql()

    assert sql == "SELECT name, email FROM users"
  end

  test "where clause" do
    sql =
      QueryBuilder.new("users")
      |> QueryBuilder.where("age > 18")
      |> QueryBuilder.to_sql()

    assert sql == "SELECT * FROM users WHERE age > 18"
  end

  test "multiple where clauses are joined with AND" do
    sql =
      QueryBuilder.new("users")
      |> QueryBuilder.where("age > 18")
      |> QueryBuilder.where("active = true")
      |> QueryBuilder.to_sql()

    assert sql == "SELECT * FROM users WHERE age > 18 AND active = true"
  end

  test "limit clause" do
    sql =
      QueryBuilder.new("users")
      |> QueryBuilder.limit(10)
      |> QueryBuilder.to_sql()

    assert sql == "SELECT * FROM users LIMIT 10"
  end

  test "order_by clause" do
    sql =
      QueryBuilder.new("users")
      |> QueryBuilder.order_by("name")
      |> QueryBuilder.to_sql()

    assert sql == "SELECT * FROM users ORDER BY name"
  end

  test "order_by with direction" do
    sql =
      QueryBuilder.new("users")
      |> QueryBuilder.order_by("created_at", :desc)
      |> QueryBuilder.to_sql()

    assert sql == "SELECT * FROM users ORDER BY created_at DESC"
  end

  test "full query with all clauses" do
    sql =
      QueryBuilder.new("users")
      |> QueryBuilder.select(["name", "email"])
      |> QueryBuilder.where("age > 18")
      |> QueryBuilder.where("active = true")
      |> QueryBuilder.order_by("name")
      |> QueryBuilder.limit(5)
      |> QueryBuilder.to_sql()

    assert sql ==
             "SELECT name, email FROM users WHERE age > 18 AND active = true ORDER BY name LIMIT 5"
  end
end
