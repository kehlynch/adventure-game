defmodule Ag.Settings.Stats do
  alias Ag.Settings

  def init!(pid) do
    set_stats!(pid, 12, 14, 10, 9, 16, 8)
  end

  def set_stats!(pid, dex, str, con, int, cha, wis) do
    update_stats!(pid, %{dex: dex, str: str, con: con, int: int, cha: cha, wis: wis})
  end

  def update_stats!(pid, %{} = stats) do
    new_stats =
      pid
      |> Settings.get_setting(:stats, %{})
      |> Map.merge(stats)

    Settings.update_setting!(pid, :stats, new_stats)
  end

  def get_stat!(pid, stat) do
    pid
    |> Settings.get_setting(:stats)
    |> Map.get(stat)
  end

  def get_stat_mod!(pid, stat) do
    case get_stat!(pid, stat) do
      nil -> nil
      stat -> (stat - 10) / 2
    end
  end

  def roll(sides \\ 20) do
    Enum.random(1..sides)
  end

  def pass?(pid, stat, difficulty) do
    mod = get_stat_mod!(pid, stat)
    roll = roll()

    cond do
      roll == 20 -> {:succeed, :n20}
      mod + roll >= difficulty -> {:succeed, nil}
      roll == 1 -> {:fail, :n1}
      true -> {:fail, nil}
    end
  end
end
