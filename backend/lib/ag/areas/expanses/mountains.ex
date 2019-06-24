defmodule Ag.Areas.Expanses.Mountains do
  use Ag.Expanses.Default,
    slug: :mountains,
    boundaries: {20, 10, 11, -10},
    path_desc: "narrow stone paths wind through the mountains"

  alias Ag.{Areas, Items, Weathers}
  alias Ag.Settings.{Stats, Status, Time}
  alias Ag.Options.Option
  alias Ag.Areas.Places

  @impl true
  def init(pid) do
    r = Stats.roll()
    init_tree(pid, r)
  end

  def init_tree(pid, r) when r >= 17 do
    set_setting!(pid, :berry_tree, true)
  end

  def init_tree(_pid, _r), do: nil

  @impl true
  def get_desc(pid) do
    [
      get_main_desc(pid),
      Places.get_remote_desc(pid),
      get_exits_desc(pid),
      get_berry_tree_desc(pid),
      Weathers.get_desc(pid),
      Status.get_desc(pid)
    ]
  end

  defp get_main_desc(_pid) do
    "You in the mountains"
  end

  def get_berry_tree_desc(pid) do
    desc = "There is a tree with some tasty looking berrys on it"
    if get_setting(pid, :berry_tree), do: desc
  end

  @impl true
  def get_options(pid) do
    options = super(pid)
    # TODO need to call something here to handle all opts
    loc_options = [get_berry_tree_option(pid)]

    options ++ loc_options
  end

  def get_berry_tree_option(pid) do
    option = %Option{slug: :berry_tree, text: "pick berries from tree", type: "Area"}

    if get_setting(pid, :berry_tree), do: option
  end

  @impl true
  def apply_choice!(pid, %{slug: :stonewick}) do
    Areas.set_current_area!(pid, :stonewick)
    Time.advance_time!(pid)
  end

  @impl true
  def apply_choice!(pid, %{slug: :berry_tree}) do
    Items.init_item(pid, :berry)
    Status.increment_hunger!(pid, -5)
    Time.advance_time!(pid)
  end

  @impl true
  def apply_choice!(pid, choice) do
    super(pid, choice)
  end
end
