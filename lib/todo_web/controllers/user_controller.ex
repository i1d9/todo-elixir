defmodule TodoWeb.UserController do
    use TodoWeb, :controller
    alias Todo.Repo
    alias Todo.Users
    alias Todo.Users.User

    plug :authenticate_user when action in [:index, :show]

    def show(conn, %{"id" => id}) do
        user = Repo.get(User, id)
        render conn, "show.html", user: user
    end

    def index(conn, _params) do
        users = Users.list_users()
        render conn, "index.html", users: users
    end

    
    @doc """
    
    Renders the create account page

    """
    def new(conn, _params) do
        changeset = User.changeset(%User{}, %{})
        render conn, "new.html", changeset: changeset
    end


    @doc """
    
    Handles the POST request from the create account page(user/new.html)

    """
    def create(conn, %{"user" => user_params}) do
        changeset = User.registration_changeset(%User{}, user_params)
        case Repo.insert(changeset) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "#{user.first_name} created!")
                |> redirect(to: Routes.user_path(conn, :index))
            {:error, changeset} ->
                render conn, "new.html", changeset: changeset
        end            
    end

    @doc """
    
    If the user is not signed in

    """
    defp authenticate_user(conn, _opts) do
        if conn.assigns.current_user do
            conn
        else
            conn
            |> put_flash(:error, "You must be logged in to access that page")
            |> redirect(to: Routes.page_path(conn, :index))
            |> halt()
        end
    end
    

end