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
     |> assign(:items, items)}
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

  # Add more handle_event functions for creating lists/items as needed
end
