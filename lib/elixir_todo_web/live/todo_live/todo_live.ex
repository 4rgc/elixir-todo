defmodule ElixirTodoWeb.TodoLive do
  use ElixirTodoWeb, :live_view

  alias ElixirTodo.Todos

  @impl true
  def mount(_params, _session, socket) do
    lists = Todos.list_lists()
    selected_list = List.first(lists)

    items =
      if selected_list,
        do: Todos.list_items_for_list(selected_list),
        else: []

    {:ok,
     socket
     |> assign(:lists, lists)
     |> assign(:selected_list, selected_list)
     |> assign(:items, items)
     |> assign(:editing_item_id, nil)
     |> assign(:new_list_name, "")
     |> assign(:new_list_color, "#22c55e")}
  end

  @impl true
  def handle_event("select_list", %{"id" => id}, socket) do
    list = Enum.find(socket.assigns.lists, &("#{&1.id}" == id))
    items = Todos.list_items_for_list(list)
    {:noreply, assign(socket, selected_list: list, items: items)}
  end

  @impl true
  def handle_event("toggle_item", %{"id" => id}, socket) do
    item = Enum.find(socket.assigns.items, &("#{&1.id}" == id))
    {:ok, _} = Todos.update_item(item, %{completed: !item.completed})
    items = Todos.list_items_for_list(socket.assigns.selected_list)
    {:noreply, assign(socket, items: items)}
  end

  @impl true
  def handle_event("edit_item", %{"id" => id}, socket) do
    item = Enum.find(socket.assigns.items, &("#{&1.id}" == id))
    {:noreply, assign(socket, editing_item_id: item.id)}
  end

  @impl true
  # NOTE: "id" comes from "phx-value-id" binding, and "value" is included because it exists
  def handle_event("save_edit", %{"id" => id, "value" => value}, socket) do
    item = Todos.get_item!(id)
    {:ok, _} = Todos.update_item(item, %{text: value})
    items = Todos.list_items_for_list(socket.assigns.selected_list)
    {:noreply, assign(socket, items: items, editing_item_id: nil)}
  end

  @impl true
  def handle_event("delete_item", %{"id" => id}, socket) do
    item = Todos.get_item!(id)
    {:ok, _} = Todos.delete_item(item)
    items = Todos.list_items_for_list(socket.assigns.selected_list)
    {:noreply, assign(socket, items: items)}
  end

  @impl true
  def handle_event("create_list", %{"name" => name, "color" => color}, socket) do
    name = String.trim(name || "")
    color = String.trim(color || "")

    if name != "" and color != "" do
      {:ok, list} = Todos.create_list(%{name: name, color: color})
      lists = Todos.list_lists()
      items = Todos.list_items_for_list(list)

      {:noreply,
       socket
       |> assign(:lists, lists)
       |> assign(:selected_list, list)
       |> assign(:items, items)
       |> assign(:new_list_name, "")
       |> assign(:new_list_color, color)}
    else
      {:noreply, socket}
    end
  end

  

  @doc """
  Handles the creation of a new item when the user finishes typing in the new item input.
  """
  @impl true
  def handle_event("create_item", %{"value" => text, "list_id" => list_id}, socket) do
    text = String.trim(text || "")

    if text != "" and list_id do
      {:ok, _item} =
        ElixirTodo.Todos.create_item(%{text: text, completed: false, list_id: list_id})

      items = ElixirTodo.Todos.list_items_for_list(socket.assigns.selected_list)
      {:noreply, assign(socket, items: items, new_item_text: "")}
    else
      {:noreply, socket}
    end
  end

  # Add more handle_event functions for creating lists/items as needed
end
