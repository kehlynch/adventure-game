defmodule AgWeb.API.GameController do
  use AgWeb, :controller

  alias Ag.{Games, Settings, Stores, Users}
  alias Ag.Stores.Store

  action_fallback AgWeb.API.FallbackController

  def index(conn, %{"user_id" => user_id}) do

    games = 
      user_id
      |> Users.list_user_stores()
      |> Enum.each(fn %Store{data: data, id: id} ->
        %{
          id: id,
          name: data.character_name
        }
      end)

    render(conn, "index.json", games: games)
  end

  def show(conn, %{"id" => store_id}) do
    render(conn, "show.json", store_id: store_id, game: get_game(store_id))
  end

  def create(conn, params) do
    %Store{id: store_id} = Stores.create_store!(params)
    pid = Settings.start_link(store_id)
    Games.init_game!(pid)
    render(conn, "show.json", store_id: store_id, game: Games.get_game(pid))
  end

  defp get_game(store_id) do
    store_id
    |> Settings.start_link()
    |> Games.get_game()
  end
end
