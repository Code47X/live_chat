defmodule LiveChat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string
      add :chat_room_id, references(:chat_rooms)

      timestamps()
    end
  end
end
