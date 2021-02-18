defmodule BullsWeb.GameChannel do
  use BullsWeb, :channel

  alias Bulls.Game

  @impl true
  def join("game:" <> name, payload, socket) do
    if authorized?(payload) do
      game = Game.new
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
    new_game = Game.guess(old_game, gg)
    new_socket = assign(old_socket, :game, new_game)
    view = Game.view(new_game)
    {:reply, {:ok, view}, new_socket}
  end

  @impl true
  def handle_in("reset", _payload, socket) do
    game = Game.new
    socket = assign(socket, :game, game)
    view = Game.view(game)
    {:reply, {:ok, view}, socket}
  end

  defp authorized?(_payload) do
    true
  end
end
