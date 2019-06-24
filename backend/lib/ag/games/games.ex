defmodule Ag.Games.Game do
  defstruct name: "", area: "", inventory: []
end

defmodule Ag.Games do
  alias Ag.{Areas, Items, Weathers}
  alias Ag.Settings.{Position, Stats, Status, Time}
  alias Ag.Games.Game
  import Ecto.Query, warn: false

  def get_game(pid) do
    %Game{
      area: Areas.get_area(pid),
      inventory: Items.get_inventory(pid),
      name: "Game!"
    }
  end

  def init_game!(pid) do
    Areas.init!(pid)
    Items.init!(pid)
    Position.init!(pid)
    Stats.init!(pid)
    Status.init!(pid)
    Time.init!(pid)
    Weathers.init!(pid)
  end

  def apply_choice!(pid, %{choice_type: :area} = choice) do
    Areas.apply_choice!(pid, choice)
  end

  def apply_choice!(pid, %{choice_type: :item} = choice) do
    Items.apply_choice!(pid, choice)
  end
end
