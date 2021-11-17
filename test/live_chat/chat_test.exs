defmodule LiveChat.ChatTest do
  use LiveChat.DataCase

  alias LiveChat.Chat

  describe "chat_rooms" do
    alias LiveChat.Chat.ChatRoom

    import LiveChat.ChatFixtures

    @invalid_attrs %{name: nil, slug: nil}

    test "list_chat_rooms/0 returns all chat_rooms" do
      chat_room = chat_room_fixture()
      assert Chat.list_chat_rooms() == [chat_room]
    end

    test "get_chat_room!/1 returns the chat_room with given id" do
      chat_room = chat_room_fixture()
      assert Chat.get_chat_room!(chat_room.id) == chat_room
    end

    test "create_chat_room/1 with valid data creates a chat_room" do
      valid_attrs = %{name: "some name", slug: "some slug"}

      assert {:ok, %ChatRoom{} = chat_room} = Chat.create_chat_room(valid_attrs)
      assert chat_room.name == "some name"
      assert chat_room.slug == "some slug"
    end

    test "create_chat_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_chat_room(@invalid_attrs)
    end

    test "update_chat_room/2 with valid data updates the chat_room" do
      chat_room = chat_room_fixture()
      update_attrs = %{name: "some updated name", slug: "some updated slug"}

      assert {:ok, %ChatRoom{} = chat_room} = Chat.update_chat_room(chat_room, update_attrs)
      assert chat_room.name == "some updated name"
      assert chat_room.slug == "some updated slug"
    end

    test "update_chat_room/2 with invalid data returns error changeset" do
      chat_room = chat_room_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_chat_room(chat_room, @invalid_attrs)
      assert chat_room == Chat.get_chat_room!(chat_room.id)
    end

    test "delete_chat_room/1 deletes the chat_room" do
      chat_room = chat_room_fixture()
      assert {:ok, %ChatRoom{}} = Chat.delete_chat_room(chat_room)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_chat_room!(chat_room.id) end
    end

    test "change_chat_room/1 returns a chat_room changeset" do
      chat_room = chat_room_fixture()
      assert %Ecto.Changeset{} = Chat.change_chat_room(chat_room)
    end
  end

  describe "messages" do
    alias LiveChat.Chat.Message

    import LiveChat.ChatFixtures

    @invalid_attrs %{body: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chat.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chat.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{body: "some body"}

      assert {:ok, %Message{} = message} = Chat.create_message(valid_attrs)
      assert message.body == "some body"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{body: "some updated body"}

      assert {:ok, %Message{} = message} = Chat.update_message(message, update_attrs)
      assert message.body == "some updated body"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, @invalid_attrs)
      assert message == Chat.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chat.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chat.change_message(message)
    end
  end
end
