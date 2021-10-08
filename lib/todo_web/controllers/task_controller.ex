defmodule TodoWeb.TaskController do
  use TodoWeb, :controller

  alias Todo.Content
  alias Todo.Content.Task
  alias Todo.Repo
  

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),[conn, conn.params, conn.assigns.current_user])
  end

  defp user_tasks(user) do
    Ecto.assoc(user, :tasks)
  end

  def index(conn, _params, user) do
    tasks = Repo.all(user_tasks(user))
    render(conn, "index.html", tasks: tasks)
  end



  @doc """
  
  Build a changeset with an association with the currently logged user

  used both in new and create action

  """
  def new(conn, _params, user) do

    changeset = 
      user
      |> Ecto.build_assoc(:tasks)
      |> Todo.Content.Task.changeset(%{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}, user) do

    changeset = 
      user
      |> Ecto.build_assoc(:tasks)
      |> Todo.Content.Task.changeset(task_params)

    case Repo.insert(changeset) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    task = Repo.get!(user_tasks(user), id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}, user) do
    task = Repo.get!(user_tasks(user), id)
    changeset = Content.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}, user) do
    task = Repo.get!(user_tasks(user), id)
    case Content.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    task = Repo.get!(user_tasks(user), id)
    {:ok, _task} = Content.delete_task(task)
    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
