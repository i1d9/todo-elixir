defmodule Todo.Users do
    alias Todo.Users.User 
    alias Todo.Repo
    import Ecto.Query

    def get_user(id) do
        Repo.get(User, id)
    end

    def list_users() do
        query = User |> order_by(desc: :id)
        Repo.all(query)
    end


    def all(_module), do: []

    def get_by(params) do
        Enum.find all(User), fn map ->
            Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
        end
    end


end