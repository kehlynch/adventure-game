defmodule AgWeb.API.ResponseController do
  use AgWeb, :controller
  import Ag.Helpers
  alias Ag.{Games, Settings}
  action_fallback AgWeb.API.FallbackController

  def create(conn, %{"game_id" => store_id, "choice" => choice} = params) do
    IO.puts "***"
    IO.inspect params

    choice = atomise(choice)
    pid = Settings.start_link(store_id)
    message = 
      pid
      |> Games.apply_choice!(choice)

    IO.puts message

    game = Games.get_game(pid)
    render(conn, "response.json", game: game, message: message, store_id: store_id)
  end

  def get_option(%{"selections" => selections}) do
    selections
    |> Enum.map(&Map.get(&1, "slug"))
    |> atomise()
    |> Enum.at(0)
  end

  def get_options(%{}), do: []

  def get_text(%{"text" => ""}), do: nil
  def get_text(%{"text" => text}), do: text
  def get_text(%{}), do: nil
end
