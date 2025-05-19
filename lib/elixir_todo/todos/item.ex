defmodule ElixirTodo.Todos.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :text, :string
    field :completed, :boolean, default: false
    field :list_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:text, :completed, :list_id])
    |> validate_required([:text, :completed, :list_id])
  end
end
