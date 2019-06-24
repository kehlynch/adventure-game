defmodule Ag.Areas.Places.Clearing do
  use Ag.Places.Default,
    slug: :clearing,
    location: {7, 4},
    options: %{
      flowers: "Pick flowers",
      sit: "Have a nice sit",
      north: "North",
      south: "South",
      east: "East",
      west: "West"
    },
    entry_option: "Clearing",
    remote_desc_text: "a small clearing"

  alias Ag.Settings.{Status, Time}
  alias Ag.{Items, Weathers}

  @impl true
  def get_desc(pid) do
    [
      base_desc(),
      time_of_day_desc(pid),
      Status.get_desc(pid)
    ]
  end

  def base_desc() do
    """
    You are in a small clearing. There are some flowers here.
    """
  end

  def time_of_day_desc(pid) do
    weather = Weathers.get_desc(pid)

    case Time.get_time_of_day(pid) do
      :morning ->
        """
          It is morning and #{weather}.
        """

      :day ->
        """
          It is daytime and #{weather}.
        """

      :afternoon ->
        """
          It is daytime and #{weather}.
        """

      :evening ->
        """
          It is evening and #{weather}.
        """

      :night ->
        """
          It is nighttime and #{weather}.
        """
    end
  end

  @impl true
  def apply_choice!(pid, %{slug: :flowers}) do
    Items.init_item(pid, :flowers)
  end

  @impl true
  def apply_choice!(pid, choice) do
    super(pid, choice)
  end
end
