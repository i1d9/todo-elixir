defmodule TodoWeb.UserSocket do
    use Phoenix.Socket

    # Link to the channel controller
    channels "tasks:*", TodoWeb.TaskChannel

    ## Transports
    transport :websocket, Phoenix.Transports.WebSocket
    # transport :longpoll, Phoenix.Transports.LongPoll


    def connect(_params, socket) do
        {:ok, socket}
    end


    def id(_socket), do: nil


end