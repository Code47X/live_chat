# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveChat.Repo.insert!(%LiveChat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LiveChat.Chat.ChatRoom
alias LiveChat.Chat.Message

# Chat.create_chat_room(%{
#   name: "Elixir"
# })

# Chat.create_chat_room(%{
#   name: "Phoenix Chat"
# })

LiveChat.Repo.insert!(%ChatRoom{
  name: "Elixir",
  slug: "elixir",
  messages: [
    %Message{body: "Hey"},
    %Message{body: "What up"}
  ]
})

LiveChat.Repo.insert!(%ChatRoom{
  name: "Phoenix Chat",
  slug: "phoenix-chat",
  messages: [
    %Message{body: "Phoenix is cool"},
    %Message{body: "Same with liveview"}
  ]
})
