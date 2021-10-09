ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Todo.Repo, :manual)


defmodule Todo.TestHelpers do
    alias Todo.Repo

    def create_user(attrs \\ %{}) do
        changes = Map.merge(%{
            first_name: "Test",
            second_name: "User",
            email: "test@user.com",
            phone: "0712345678",
            password: "12345678",
        }, attrs)

        %Todo.Users.User{}
        |> Todo.Users.User.registration_changeset(changes)
        |> Repo.insert!()
    end

    def create_task(task, attrs \\ %{}) do
        task
        |> Ecto.build_assoc(:tasks, attrs)
        |> Repo.insert!()
    end
end

