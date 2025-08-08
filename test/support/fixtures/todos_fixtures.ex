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
    list = Map.get(attrs, :list) || list_fixture()

    base_attrs = %{
      completed: true,
      text: "some text",
      list_id: list.id
    }

    final_attrs =
      attrs
      |> Map.delete(:list)
      |> Enum.into(base_attrs)

    {:ok, item} = ElixirTodo.Todos.create_item(final_attrs)
    item
  end
end
