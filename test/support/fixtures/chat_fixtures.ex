defmodule LiveChat.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveChat.Chat` context.
  """

  @doc """
  Generate a chat_room.
  """
  def chat_room_fixture(attrs \\ %{}) do
    {:ok, chat_room} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> LiveChat.Chat.create_chat_room()

    chat_room
  end

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        body: "some body"
      })
      |> LiveChat.Chat.create_message()

    message
  end
end
