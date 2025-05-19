defmodule ElixirTodo.TodosTest do
  use ElixirTodo.DataCase

  alias ElixirTodo.Todos

  describe "lists" do
    alias ElixirTodo.Todos.List

    import ElixirTodo.TodosFixtures

    @invalid_attrs %{name: nil, color: nil}

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Todos.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Todos.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      valid_attrs = %{name: "some name", color: "some color"}

      assert {:ok, %List{} = list} = Todos.create_list(valid_attrs)
      assert list.name == "some name"
      assert list.color == "some color"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      update_attrs = %{name: "some updated name", color: "some updated color"}

      assert {:ok, %List{} = list} = Todos.update_list(list, update_attrs)
      assert list.name == "some updated name"
      assert list.color == "some updated color"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_list(list, @invalid_attrs)
      assert list == Todos.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Todos.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Todos.change_list(list)
    end
  end

  describe "items" do
    alias ElixirTodo.Todos.Item

    import ElixirTodo.TodosFixtures

    @invalid_attrs %{text: nil, completed: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Todos.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Todos.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{text: "some text", completed: true}

      assert {:ok, %Item{} = item} = Todos.create_item(valid_attrs)
      assert item.text == "some text"
      assert item.completed == true
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{text: "some updated text", completed: false}

      assert {:ok, %Item{} = item} = Todos.update_item(item, update_attrs)
      assert item.text == "some updated text"
      assert item.completed == false
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_item(item, @invalid_attrs)
      assert item == Todos.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Todos.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Todos.change_item(item)
    end
  end
end
