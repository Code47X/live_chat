defmodule LiveChatWeb.ChatRoomLive.Show do
  use Surface.LiveView

  alias LiveChat.Chat
  alias LiveChat.Chat.Message
  alias Surface.Components.Form
  alias Surface.Components.Form.TextInput
  alias Surface.Components.Form.HiddenInput

  data chat_room, :struct
  data messages, :list, default: []

  def mount(%{"slug" => slug}, _session, socket) do
    chat_room = Chat.get_chat_room!(slug)

    if connected?(socket) do
      Chat.subscribe(chat_room)

      {:ok,
       socket
       |> assign(chat_room: chat_room)
       |> assign(messages: Chat.load_last_50_messages(chat_room)),
       temporary_assigns: [messages: []]}
    else
      {:ok,
       socket
       |> assign(chat_room: chat_room)}
    end
  end

  def handle_event("create-message", %{"message" => params}, socket) do
    case Chat.create_message(params) do
      {:ok, message} ->
        Chat.broadcast_message(message, socket.assigns.chat_room)
        {:noreply, update(socket, :messages, fn messages -> [message | messages] end)}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end

  def handle_info(%Message{} = message, socket) do
    {:noreply, update(socket, :messages, fn messages -> [message | messages] end)}
  end
end
