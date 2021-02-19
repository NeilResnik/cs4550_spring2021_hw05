defmodule BullsWeb.GameChannel do
  use BullsWeb, :channel

  alias Bulls.Game

  @impl true
  def join("bulls:" <> name, payload, socket) do
    if authorized?(payload) do
      game = Game.new
      IO.inspect game
      socket = socket
               |> assign(:name, name)
               |> assign(:game, game)
      view = Game.view(game)
      {:ok, view, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_in("guess", %{"guess" => gg}, old_socket) do
    old_game = old_socket.assigns[:game]
    if Game.canGuess(old_game) do
      new_game = Game.guess(old_game, String.graphemes(gg))
      IO.inspect new_game
      new_socket = assign(old_socket, :game, new_game)
      view = Game.view(new_game)
      {:reply, {:ok, view}, new_socket}
    else
      {:reply, {:error, "Game Over"}, old_socket}
    end
  end

  @impl true
  def handle_in("reset", _payload, socket) do
    game = Game.new
    IO.inspect game
    socket = assign(socket, :game, game)
    view = Game.view(game)
    {:reply, {:ok, view}, socket}
  end

  defp authorized?(_payload) do
    true
  end
end
