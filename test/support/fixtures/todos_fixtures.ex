defmodule ElixirTodo.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirTodo.Todos` context.
  """

  @doc """
  Generate a list.
  """
  def list_fixture(attrs \\ %{}) do
    {:ok, list} =
      attrs
      |> Enum.into(%{
        color: "some color",
        name: "some name"
      })
      |> ElixirTodo.Todos.create_list()

    list
  end

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        completed: true,
        text: "some text"
      })
      |> ElixirTodo.Todos.create_item()

    item
  end
end
