defmodule Ag.Settings.Status do
  alias Ag.Settings

  def init!(pid) do
    set_hunger!(pid, 0)
  end

  def get_desc(pid) do
    %{hunger: hunger} = get_status(pid)

    cond do
      hunger > 16 -> "You are starving"
      hunger > 12 -> "You are very hungry"
      hunger > 7 -> "You are hungry"
      true -> nil
    end
  end

  def advance_status!(pid, increment) do
    pid
    |> set_hunger!(get_hunger(pid) + increment)
  end

  def get_hunger(pid) do
    pid
    |> Settings.get_setting([:status, :hunger])
  end

  def increment_hunger!(pid, increment) when is_number(increment) do
    current = get_hunger(pid)

    pid
    |> set_hunger!(current + increment)
  end

  def set_hunger!(pid, hunger) when is_number(hunger) do
    pid
    |> Settings.update_setting!([:status, :hunger], hunger)
  end

  def get_status(pid) do
    pid
    |> Settings.get_setting(:status)
  end

  def set_status!(pid, status) do
    pid
    |> Settings.update_setting!(:status, status)
  end
end
