defmodule ElixirTodo.Repo.Migrations.CreateListsTable do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :name, :string
      add :color, :string

      timestamps(type: :utc_datetime)
    end

    create index(:lists, [:name])
  end
end
