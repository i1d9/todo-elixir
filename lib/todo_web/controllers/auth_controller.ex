defmodule TodoWeb.AuthController do
    use TodoWeb, :controller
    alias Todo.Repo
    alias Todo.Users
    alias Todo.Users.User
    


    def new(conn, _params) do
        changeset = User.changeset(%User{}, %{})
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"user" => params}) do
        changeset = User.changeset(%User{}, params)
        {:ok, user} = Repo.insert(changeset) 
        case Repo.insert(changeset) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "#{user.first_name} created!")
                |> redirect(to: Routes.auth_path(conn, :index))
            {:error, changeset} ->
                render conn, "new.html", changeset: changeset

        end
        
            
    end

    def show(conn, %{"id" => id}) do
        user = Repo.get(User, id)
        render conn, "show.html", user: user
        
    end

    def index(conn, _params) do
        users = Users.list_users()
        render conn, "index.html", users: users
    end

    

end