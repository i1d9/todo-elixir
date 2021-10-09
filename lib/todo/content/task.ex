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
  @optional_fields ~w(category_id) 

  @doc """
  
  The assoc_constraint function guarantees that a task can only be added if the category exists

  """
  def changeset(task, attrs \\ :empty) do
    task
    |> cast(attrs, [:title, :description, :category_id])
    |> assoc_constraint(:category)
  end
end
