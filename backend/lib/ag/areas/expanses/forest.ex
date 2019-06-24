defmodule Ag.Areas.Expanses.Forest do
  use Ag.Expanses.Default,
    slug: :forest,
    boundaries: {10, 10, -10, -10},
    path_desc: "dirt paths snake through the forest"

  alias Ag.{Areas, Items, Weathers}
  alias Ag.Settings.{Stats, Status, Time}
  alias Ag.Options.Option
  alias Ag.Areas.Places

  @impl true
  def init(pid) do
    if !get_setting(pid, :init) do
      r = Stats.roll()
      init_tree(pid, r)
      set_setting!(pid, :init, true)
    end
  end

  def init_tree(pid, r) when r >= 17 do
    set_setting!(pid, :apple_tree, true)
  end

  def init_tree(_pid, _r), do: nil

  @impl true
  def get_desc(pid) do
    [
      get_intro_desc(pid),
      get_main_desc(pid),
      Places.get_remote_desc(pid),
      get_exits_desc(pid),
      get_apple_tree_desc(pid),
      Weathers.get_desc(pid),
      Status.get_desc(pid)
    ]
    |> List.flatten()
  end

  defp get_intro_desc(pid) do
    case Time.get_current_turn(pid) do
      0 -> [
        """
        You wake up. You are cold and damp. You can smell rotting leaves and hear
        small animal scurring about near you.
        """,
        """
        You head hurts and you have no idea who you are or how you got here.
        """,
        """
        You struggle to your feet. You are wearing a worn wool tunic and
        leather boots. Over your shoulder is a drawstring bag [check your 
        inventory ↗️]. 
        """
      ]
      _ ->
        nil
    end
  end

  defp get_main_desc(_pid) do
    "You are in a dense forest"
  end

  def get_apple_tree_desc(pid) do
    desc = "There is a tree with some tasty looking apples on it"
    if get_setting(pid, :apple_tree), do: desc
  end

  @impl true
  def get_options(pid) do
    options = super(pid)
    # TODO need to call something here to handle all opts
    loc_options = [get_apple_tree_option(pid)]

    options ++ loc_options
  end

  def get_apple_tree_option(pid) do
    option = %Option{slug: :apple_tree, text: "pick apple from tree", type: "Area"}

    if get_setting(pid, :apple_tree), do: option
  end

  @impl true
  def apply_choice!(pid, %{slug: :stonewick}) do
    Areas.set_current_area!(pid, :stonewick)
    Time.advance_time!(pid)
  end

  @impl true
  def apply_choice!(pid, %{slug: :apple_tree}) do
    Items.add(pid, :apple, 1)
    Time.advance_time!(pid)
    "You pick an apple from the tree"
  end

  @impl true
  def apply_choice!(pid, choice) do
    super(pid, choice)
  end
end
