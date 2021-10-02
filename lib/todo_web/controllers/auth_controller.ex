defmodule TodoWeb.AuthController do
    use TodoWeb, :controller

    def new(conn, _params) do
        changeset = Todo.Auth.new()
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"auth" => params}) do
        case Todo.Auth.register_user(params) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "Registered")
                |> put_session(:current_user_id, user.id) #Add Session cookie
                |> redirect(to: page_path(conn, :index))
            {:error, changeset} ->
                render conn, "new.html", changeset: changeset
        end
    end

end