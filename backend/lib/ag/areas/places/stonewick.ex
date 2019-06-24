defmodule Ag.Areas.Places.Stonewick do

  alias Ag.{Areas, Weathers}
  alias Ag.Settings.{Status, Time}

  use Ag.Places.Default,
    slug: :stonewick,
    location: {10, 3},
    options: %{
      inn: "go into the inn",
      forge: "go up to the forge",
      north: "mountains",
      south: "forest",
      east: "forest",
      west: "forest"
    },
    entry_option: "Stonewick",
    remote_desc_text: "the town of Stonewick"

  @impl true
  def get_desc(pid) do
    [
      base_desc(),
      exits_desc(),
      entry_desc(pid),
      time_of_day_desc(pid),
      Status.get_desc(pid)
    ]
  end

  def base_desc() do
    """
    You are in a small village of 20 or so crudely built stone cottages.
    """
  end

  def exits_desc() do
    """
    To the north, a stone path leads up a steep mountainside. To the south, west
    and east wide dirt tracks lead into thick forest. Nearby, you see The King's
    Rest inn and a blacksmith's forge.
    """
  end

  def entry_desc(pid) do
    case get_setting(pid, :arrival_method, nil) do
      :coach ->
        """
        The coach you arrived on stands outside the inn. The driver stands nearby,
        talking to a man and a woman dressed in dusty travelling cloaks.
        """

      _ ->
        nil
    end
  end

  def time_of_day_desc(pid) do
    weather = Weathers.get_desc(pid)

    case Time.get_time_of_day(pid) do
      :morning ->
        """
          It is morning and #{weather}. A few miners are heading up the path to
          the North.
        """

      :day ->
        """
          It is daytime and #{weather}. A few traders have set up stalls in front
          of the blacksmith's forge. The inn is open and the blacksmith is working
          at an anvil in front of the forge.
        """

      :afternoon ->
        """
          It is daytime and #{weather}. A few traders have set up stalls in front
          of the blacksmith's forge. The inn is open and the blacksmith is working
          at an anvil in front of the forge.
        """

      :evening ->
        """
          It is evening and #{weather}. A few miners are heading down the path
          from the north". The inn is open.
        """

      :night ->
        """
          It is nighttime and #{weather}. There is noone around, but you see a few
          candles burning in windows, including a couple upstairs at the inn.
        """
    end
  end

  @impl true
  def apply_choice!(pid, %{option: :north}) do
    Areas.set_current_area!(pid, :mountains)
    super(pid, :north)
  end

  @impl true
  def apply_choice!(pid, %{option: o} = choice) when o in [:south, :east, :west] do
    Areas.set_current_area!(pid, :forest)
    super(pid, choice)
  end

  @impl true
  def apply_choice!(pid, %{option: :inn}) do
    Areas.set_current_area!(pid, :inn)
  end

  @impl true
  def apply_choice!(pid, %{option: :forge}) do
    Areas.set_current_area!(pid, :forge)
  end
end
