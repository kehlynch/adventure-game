defmodule Ag.Areas.Encounters.Thieves do
  use Ag.Areas.Encounters.Default,
    slug: :thieves,
    type: "Select"

  alias Ag.Areas
  alias Ag.Settings.Stats
  alias Ag.Areas.Area
  alias Ag.Options.Option

  @thieves_options %{
    nil => [:sneak, :bluff, :join],
    fail: [:bluff, :join],
    succeed: [:listen, :leave]
  }

  @options %{
    sneak: "Try to overhear them by concealing myself in the shadows by the door",
    bluff: "Try to overhear them by nonchalently walking over and collecting their empty glasses",
    join: "Walk over and introduce yourself"
  }

  def get_area(pid) do
    %Area{
      slug: :thieves,
      type: "Select",
      desc: get_description(pid),
      options: get_options(pid)
    }
  end

  def get_options(pid) do
    snuck = Areas.get_area_setting(pid, :thieves, :snuck)

    @thieves_options
    |> Map.get(snuck)
    |> Enum.map(&struct(Option, %{slug: &1, text: get_option_text(&1)}))
  end

  defp get_option_text(slug) do
    Map.get(@options, slug)
  end

  def get_description(pid) do
    pid
    |> Areas.get_area_setting(:thieves, :snuck)
    |> do_get_description()
  end

  def do_get_description(nil = _snuck) do
    [
      "You start to walk over to the small group in the corner.",
      "What would you like to do?"
    ]
  end

  def do_get_description(:succeed = _snuck) do
    [
      """
      You affect the distinterested air of a barmaid gathering glasses. The woman talking barely glances at you and doesn't stop. Her words are slighly guarded but you gather they are planning something that evening.
      """,
      "You hear the words 'Oakchurch' and 'Storm Caller'"
    ]
  end

  def do_get_description(:fail = _snuck) do
    [
      "You sidle up to the group in the corner. It doesn't work."
    ]
  end

  def apply_choice!(pid, :sneak) do
    {snuck, _mod} = Stats.pass?(pid, :dex, 18)
    current_area = Areas.get_current_area(pid)
    Areas.set_area_setting!(pid, current_area, :snuck, snuck)
  end

  def apply_choice!(pid, :listen) do
    {snuck, _mod} = Stats.pass?(pid, :dex, 18)
    current_area = Areas.get_current_area(pid)
    Areas.set_area_setting!(pid, current_area, :listened, snuck)
  end
end
