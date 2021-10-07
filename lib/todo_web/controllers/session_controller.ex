defmodule TodoWeb.SessionController do
    use TodoWeb, :controller

    def new(conn, _) do
        if conn.assigns.current_user do
            redirect(conn, to: Routes.page_path(conn, :index))
        else
            render conn, "new.html"
        end
    end




    def create(conn, %{"session"=> %{"email" => email, "password" => pass }}) do
        case Todo.Auth.login_by_email_and_pass(conn, email, pass, repo: Todo.Repo) do
            {:ok, conn} ->
                conn
                |> put_flash(:info, "Welcome back!")
                |> redirect(to: Routes.page_path(conn, :index))
            {:error, _reason, conn} ->
                conn
                |> put_flash(:error, "Invalid username/password combination")
                |> render("new.html")
        end
    end

    def delete(conn, _) do
        conn
        |> Todo.Auth.logout()
        |> redirect(to: Routes.page_path(conn, :index))
    end
end