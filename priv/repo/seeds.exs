alias ElixirTodo.Repo
alias ElixirTodo.Todos
alias ElixirTodo.Todos.List

# Create a default list and item if there are no lists yet.
case Repo.aggregate(List, :count, :id) do
  0 ->
    {:ok, list} =
      Todos.create_list(%{
        name: "Default",
        color: "#22c55e" # green-500
      })

    _ = Todos.create_item(%{text: "Conquer the world", completed: false, list_id: list.id})
    :ok

  _ ->
    :ok
end
