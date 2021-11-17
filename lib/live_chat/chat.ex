defmodule LiveChat.Chat do
  import Ecto.Query, warn: false

  alias LiveChat.Repo
  alias LiveChat.Chat.ChatRoom
  alias LiveChat.Chat.Message

  defp topic(%ChatRoom{} = chat_room), do: "chat_room:#{chat_room.id}"

  def subscribe(%ChatRoom{} = chat_room) do
    LiveChat.PubSub
    |> Phoenix.PubSub.subscribe(topic(chat_room))
  end

  def broadcast_message(message, chat_room) do
    LiveChat.PubSub
    |> Phoenix.PubSub.broadcast(topic(chat_room), message)
  end

  def create_chat_room(attrs \\ %{}) do
    %ChatRoom{}
    |> ChatRoom.changeset(attrs)
    |> Repo.insert()
  end

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  def get_chat_room!(slug) do
    ChatRoom
    |> Repo.get_by!(slug: slug)
  end

  def load_last_50_messages(%ChatRoom{} = chat_room) do
    chat_room
    |> Ecto.assoc(:messages)
    |> order_by(:inserted_at)
    |> limit(50)
    |> Repo.all()
  end
end
