defmodule AgWeb.API.GameView do
  use AgWeb, :view

  alias AgWeb.API.AreaView
  alias Ag.Games.Game
  alias Ag.Items.Item

  def render("show.json", %{game: %Game{} = game, store_id: store_id}) do
    render_game(game, store_id)
  end

  def render("index.json", %{games: games}) do
    Map.new()
    |> Map.put(:games, Enum.map(games, &render_game_minimal(&1)))
  end

  def render_game_minimal(%{id: id, name: name}) do
    Map.new()
    |> Map.put(:id, id)
    |> Map.put(:name, name)
  end

  def render_game(%Game{} = game, store_id) do
    Map.new()
    |> Map.put(:id, store_id)
    |> Map.put(:name, game.name)
    |> Map.put(:area, AreaView.render_area(game.area))
    |> Map.put(:inventory, render_inventory(game.inventory))
  end

  def render_inventory(items) do
    items
    |> Enum.map(&render_item(&1))
  end

  def render_item(%Item{} = item) do
    Map.new()
    |> Map.put(:slug, item.slug)
    |> Map.put(:name, item.name)
    |> Map.put(:description, item.desc)
    |> Map.put(:options, item.options)
  end
end
