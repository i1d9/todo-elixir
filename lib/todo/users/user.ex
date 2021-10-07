defmodule Todo.Users.User do
    use Ecto.Schema
    import Ecto.Changeset
  

    @doc """
    
    A schema defined the structure of a database table
    It contains the properites of each column

    """
    schema "users" do
        field :first_name, :string
        field :second_name, :string
        field :email, :string
        field :phone, :string
        field :password, :string, virtual: true
        field :password_hash, :string
        has_many :tasks, Todo.Content.Task
        timestamps()
    end

    @doc """

    This function is used to validate an inbound struct according to the schema provided
    If the inbound data is not defined the default paramaeter empty will be used

    """
    
    def changeset(user, params \\ :empty) do
        user
        |> cast(params, [:first_name, :second_name, :email, :phone])
        |> validate_length(:first_name, min: 3, max: 20)
        |> validate_length(:second_name, min: 3, max: 20)
        |> validate_length(:phone, min: 10, max: 12)
        |> unique_constraint(:email)
        |> validate_format(:email, ~r/@/)
    end

    @doc """
    
    This function is used to validate and hash the password when a new account is being created

    It calls the first changeset then checks if the password has been defined, checks the length then hashes it

    """
    def registration_changeset(user, params) do
        user
        |> changeset(params) 
        |> cast(params, [:password])
        |> validate_length(:password, min: 8, max: 100)
        |> put_pass_hash()
    end

    defp put_pass_hash(changeset) do
        case changeset do
            %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
                put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
            _ ->
                changeset
        end
    end
end




