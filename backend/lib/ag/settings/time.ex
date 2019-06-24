defmodule Ag.Settings.Time do
  alias Ag.Settings
  alias Ag.Settings.{Weathers, Status}
  @initial_hour 12

  @times %{
    night: %{hours: [0, 1, 2, 3, 4], name: "nighttime"},
    morning1: %{hours: Enum.to_list(5..9), name: "morning"},
    morning2: %{hours: Enum.to_list(10..12), name: "late morning"},
    afternoon1: %{hours: Enum.to_list(13..15), name: "early afternoon"},
    afternoon2: %{hours: Enum.to_list(16..18), name: "late afternoon"},
    evening1: %{hours: Enum.to_list(18..21), name: "evening"},
    evening2: %{hours: Enum.to_list(18..24), name: "late evening"}
  }

  def init!(pid) do
    set_current_turn!(pid, 0)
  end

  def get_name(slug) do
    @times
    |> Map.get(slug)
    |> Map.get(:name)
  end

  def advance_time!(pid, increment \\ 1) do
    pid
    |> set_current_turn!(get_current_turn(pid) + increment)

    weather =
      pid
      |> Weathers.generate_weather()

    Weathers.set_current_weather!(pid, weather)
    Status.advance_status!(pid, increment)
  end

  def get_hour(pid) do
    pid
    |> get_current_turn()
    |> Kernel.+(@initial_hour)
    |> rem(24)
  end

  def get_time_of_day_name(pid) do
    pid
    |> get_time_of_day()
    |> get_name()
  end

  def get_time_of_day(pid) do
    hour = get_hour(pid)

    {time_of_day, _details} =
      @times
      |> Enum.filter(fn {_k, %{hours: hours}} ->
        Enum.member?(hours, hour)
      end)
      |> List.first()

    time_of_day
  end

  def get_current_turn(pid) do
    pid
    |> Settings.get_setting(:turn)
  end

  defp set_current_turn!(pid, turn) do
    pid
    |> Settings.update_setting!(:turn, turn)
  end
end
