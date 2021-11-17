defmodule LiveChatWeb.ChatRoomLiveTest do
  use LiveChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveChat.ChatFixtures

  @create_attrs %{name: "some name", slug: "some slug"}
  @update_attrs %{name: "some updated name", slug: "some updated slug"}
  @invalid_attrs %{name: nil, slug: nil}

  defp create_chat_room(_) do
    chat_room = chat_room_fixture()
    %{chat_room: chat_room}
  end

  describe "Index" do
    setup [:create_chat_room]

    test "lists all chat_rooms", %{conn: conn, chat_room: chat_room} do
      {:ok, _index_live, html} = live(conn, Routes.chat_room_index_path(conn, :index))

      assert html =~ "Listing Chat rooms"
      assert html =~ chat_room.name
    end

    test "saves new chat_room", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.chat_room_index_path(conn, :index))

      assert index_live |> element("a", "New Chat room") |> render_click() =~
               "New Chat room"

      assert_patch(index_live, Routes.chat_room_index_path(conn, :new))

      assert index_live
             |> form("#chat_room-form", chat_room: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#chat_room-form", chat_room: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.chat_room_index_path(conn, :index))

      assert html =~ "Chat room created successfully"
      assert html =~ "some name"
    end

    test "updates chat_room in listing", %{conn: conn, chat_room: chat_room} do
      {:ok, index_live, _html} = live(conn, Routes.chat_room_index_path(conn, :index))

      assert index_live |> element("#chat_room-#{chat_room.id} a", "Edit") |> render_click() =~
               "Edit Chat room"

      assert_patch(index_live, Routes.chat_room_index_path(conn, :edit, chat_room))

      assert index_live
             |> form("#chat_room-form", chat_room: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#chat_room-form", chat_room: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.chat_room_index_path(conn, :index))

      assert html =~ "Chat room updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes chat_room in listing", %{conn: conn, chat_room: chat_room} do
      {:ok, index_live, _html} = live(conn, Routes.chat_room_index_path(conn, :index))

      assert index_live |> element("#chat_room-#{chat_room.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#chat_room-#{chat_room.id}")
    end
  end

  describe "Show" do
    setup [:create_chat_room]

    test "displays chat_room", %{conn: conn, chat_room: chat_room} do
      {:ok, _show_live, html} = live(conn, Routes.chat_room_show_path(conn, :show, chat_room))

      assert html =~ "Show Chat room"
      assert html =~ chat_room.name
    end

    test "updates chat_room within modal", %{conn: conn, chat_room: chat_room} do
      {:ok, show_live, _html} = live(conn, Routes.chat_room_show_path(conn, :show, chat_room))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Chat room"

      assert_patch(show_live, Routes.chat_room_show_path(conn, :edit, chat_room))

      assert show_live
             |> form("#chat_room-form", chat_room: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#chat_room-form", chat_room: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.chat_room_show_path(conn, :show, chat_room))

      assert html =~ "Chat room updated successfully"
      assert html =~ "some updated name"
    end
  end
end
