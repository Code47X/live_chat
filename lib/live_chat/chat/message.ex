defmodule LiveChat.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias LiveChat.Chat.ChatRoom

  schema "messages" do
    field :body, :string

    belongs_to :chat_room, ChatRoom

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :chat_room_id])
    |> validate_required([:body, :chat_room_id])
  end
end
