defmodule Todo.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :second_name, :string
      add :email, :string
      add :phone, :string
      add :password_hash, :string

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end
