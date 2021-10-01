defmodule Todo.Items do
    @moduledoc """
    Handles CRUD operations for the Items table
    """
    alias Todo.Items.Item
    alias Todo.Repo #Imports a repository that maps to an underlying data store, controlled by the Postgres adapter
    import Ecto.Query

    @doc """
    Gets a specific item by ID
    """
    def get_item(id) do
        Repo.get(Item, id)
    end

    @doc """
    Fetches all items and orders them in descending order
    """
    def list_items() do
        query = Item |> order_by(desc: :id)
        Repo.all(query)
    end


    @doc """
    Updates an Item as completed
    """
    def mark_completed(id) do
        item = Repo.get(Item, id)
        item = Ecto.Changeset.change item, completed: true
        Repo.update(item)
    end

    @doc """
    Deletes an Item
    """
    def delete_item(id) do
        item =  Repo.get(Item, id)
        Repo.delete(item)
    end


    @doc """
    Creates a new Item
    """
    def create_item(params) do
        %Item{}
        |> Item.changeset(params)
        |> Repo.insert()
    end
end
