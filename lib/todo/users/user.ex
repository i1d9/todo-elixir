defmodule Todo.Users.User do
    use Ecto.Schema
    import Ecto.Changeset
  
    #A schema defines the native form of data in the database

    schema "users" do
        field :first_name, :string
        field :second_name, :string
        field :email, :string
        field :phone, :string
        field :password, :string, virtual: true
        field :password_hash, :string
        timestamps()
    end

    #If no params are passsed we pass an empty map which will invalidate the changeset 
    def changeset(user, params \\ :empty) do
        user
        |> cast(params, [:first_name, :second_name, :email, :phone])
        |> validate_length(:first_name, min: 3, max: 20)
        |> validate_length(:second_name, min: 3, max: 20)
        |> validate_length(:phone, min: 10, max: 12)
    end
end




