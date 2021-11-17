defmodule LiveChat.Repo.Migrations.CreateChatRooms do
  use Ecto.Migration

  def change do
    create table(:chat_rooms) do
      add :name, :string
      add :slug, :string

      timestamps()
    end

    create unique_index(:chat_rooms, [:slug])
  end
end
