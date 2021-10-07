defmodule Todo.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todo.Content` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Todo.Content.create_task()

    task
  end
end
