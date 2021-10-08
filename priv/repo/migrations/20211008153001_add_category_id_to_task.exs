defmodule Todo.Repo.Migrations.AddCategoryIdToTask do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :category_id, references(:categories)
    end
  end
end
