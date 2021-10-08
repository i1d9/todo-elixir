defmodule Todo.Content.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :title, :string
    field :user_id, :id
    belongs_to :category, Todo.Category
    

    timestamps()
  end

  @required_fields ~w(title description)
  @optional_fields ~w(categories_id) 

  @doc false
  def changeset(task, attrs \\ :empty) do
    task
    |> cast(attrs, @required_fields, @optional_fields)
  end
end
