defmodule Todo.Auth do

    import Plug.Conn
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
end