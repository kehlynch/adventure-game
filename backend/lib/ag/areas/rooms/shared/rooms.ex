defmodule Ag.Areas.Rooms do
  alias Ag.Settings

  alias Ag.Areas.Rooms

  @modules %{
    inn: Rooms.Inn,
    forge: Rooms.Forge,
  }

  defp get_module(slug), do: Map.get(@modules, slug)

  def modules(), do: @modules

  def get_current_room(pid) do
    Settings.get_setting(pid, :current_room)
  end

  def set_current_room!(pid, value) do
    get_module(value).set_to_current!(pid) 
  end
end
