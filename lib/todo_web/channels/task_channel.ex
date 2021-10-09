defmodule TodoWeb.TaskChannel do
    use TodoWeb, :channel

    @doc """
    On join 
    """
    def join("tasks:"<> task_id, _params, socket) do
        {:ok, assign(socket, :task_id, String.to_integer(task_id))}
    end
end