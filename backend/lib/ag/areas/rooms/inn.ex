defmodule Ag.Areas.Rooms.Inn do
  use Ag.Areas.Rooms.Default,
    slug: :inn,
    type: "Select",
    options: %{
      barman: "go up to the barman",
      thieves: "go over to the group by the window",
      leave: "leave the inn"
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
    You are in an inn.
    """
  end

  def exits_desc() do
    """
    There's a large, red faced man behind the bar, pouring
    pints of ale from a single grubby looking tap.
    In a dusty corner near the door, two women and a man are talking quietly
    and intently, bent over their drinks
    """
  end

  def time_of_day_desc(pid) do
    case Time.get_time_of_day(pid) do
      _ -> nil
    end
  end

  @impl true
  def apply_choice!(pid, %{option: :leave}) do
    Areas.set_current_area!(pid, :stonewick)
  end

  @impl true
  def apply_choice!(pid, %{option: :barman}) do
    Areas.set_current_area!(pid, :barman)
  end

  @impl true
  def apply_choice!(pid, %{option: :thieves}) do
    Areas.set_current_area!(pid, :thieves)
  end
end
