defmodule Todo.Auth do

    import Plug.Conn
    import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

    @moduledoc """

    Authentication module plug

    """

    @doc """
    
    Extracts the repository from the key

    """
    
    def init(opts) do
        Keyword.fetch!(opts, :repo)
    end



    @doc """
    
    Check if there is a user in the seeions and store it in conn.assigns for every incoming request

    The conn.assigns can be accessed from controllers and views

    """

    def call(conn, repo) do
        IO.puts("Hello")
        user_id = get_session(conn, :user_id)
        user = user_id && repo.get(Todo.Users.User, user_id)
        assign(conn, :current_user, user)
    end


    @doc """
    
    When a user is signing into their account, their user id is assigned into the session
    Setting the renew option to true prevents session fixation attacks. It
    sends the session cookie back to the client with a different identifier

    """
    def login(conn, user) do
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
    end


    @doc """
    
    Checks whether there is a user associated with the email given
        1. if there is an existing user, 
            a. compares the hashes and signs them in
            b. else returns an error if the hashes dont match

    """

    def login_by_email_and_pass(conn, email, given_password, opts) do
        repo = Keyword.fetch!(opts, :repo)
        user = repo.get_by(Todo.Users.User, email: email)

        cond do
            user && checkpw(given_password, user.password_hash) ->
                {:ok, login(conn, user)}
            user ->
                {:error, :unauthorized, conn}
            true ->
                dummy_checkpw()
                {:error, :not_found, conn}
        end
    end


    def logout(conn) do
        configure_session(conn, drop: true)
    end
end