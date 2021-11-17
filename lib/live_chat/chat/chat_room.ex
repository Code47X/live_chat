defmodule LiveChat.Chat.ChatRoom do
  use Ecto.Schema
  import Ecto.Changeset

  alias LiveChat.Chat.Message

  @derive {Phoenix.Param, key: :slug}
  schema "chat_rooms" do
    field :name, :string
    field :slug, :string

    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(chat_room, attrs) do
    chat_room
    |> cast(attrs, [:name])
    |> build_slug()
    |> validate_required([:name, :slug])
    |> unique_constraint(:slug)
  end

  defp build_slug(changeset) do
    case get_field(changeset, :name) do
      nil -> changeset
      name -> put_change(changeset, :slug, Slug.slugify(name))
    end
  end
end
