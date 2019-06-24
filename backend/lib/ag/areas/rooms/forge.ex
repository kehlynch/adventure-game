defmodule Ag.Areas.Rooms.Forge do
  use Ag.Areas.Rooms.Default,
    slug: :forge,
    type: "Select",
    options: %{
      leave: "leave the forge"
    }

  alias Ag.Areas
  alias Ag.Settings.{Status, Time}

  @impl true
  def get_desc(pid) do
    [
      base_desc(),
      exits_desc(),
      time_of_day_desc(pid),
      Status.get_desc(pid)
    ]
  end

  def base_desc() do
    """
    You are in a forge
    """
  end

  def exits_desc() do
    """
    There is a door leading back to Stonewick
    """
  end

  def time_of_day_desc(pid) do
    case Time.get_time_of_day(pid) do
      _ -> nil
    end
  end

  @impl true
  def apply_choice!(pid, :leave) do
    Areas.set_current_area!(pid, :stonewick)
  end
end
