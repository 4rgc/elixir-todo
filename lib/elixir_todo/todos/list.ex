defmodule ElixirTodo.Todos.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :name, :string
    field :color, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :color])
    |> validate_required([:name, :color])
  end
end
