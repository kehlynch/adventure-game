defmodule Ag.Areas.Encounters do
  alias Ag.Settings

  alias Ag.Areas.Encounters

  @modules %{
    barman: Encounters.Barman,
    thieves: Encounters.Thieves,
  }

  defp get_module(slug), do: Map.get(@modules, slug)

  def modules(), do: @modules

  def get_current_encounter(pid) do
    Settings.get_setting(pid, :current_encounter)
  end

  def set_current_encounter!(pid, value) do
    get_module(value).set_to_current!(pid) 
  end
end
