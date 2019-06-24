defmodule Ag.Areas.Places do
  alias Ag.Settings
  alias Ag.Settings.Position

  @modules %{
    stonewick: Ag.Areas.Places.Stonewick,
    clearing: Ag.Areas.Places.Clearing,
  }

  defp get_module(slug), do: Map.get(@modules, slug)

  def modules(), do: @modules

  def get_current_place(pid) do
    Settings.get_setting(pid, :current_place)
  end

  def set_current_place!(pid, value) do
    get_module(value).set_to_current!(pid) 
  end

  def get_remote_desc(pid) do
    @modules
    |> Enum.map(fn {_slug, module} ->
      module.get_remote_desc(pid)
    end)
    |> Enum.reject(& is_nil(&1))
    |> List.flatten()
    |> Enum.join(". ")
  end

  def get_entry_options(pid) do
    @modules
    |> Enum.map(fn {_slug, module} ->
      module.get_entry_option(pid)
    end)
    |> Enum.reject(& is_nil(&1))
  end

  def get_entry_dirs(pid) do
    pid
    |> get_entry_options()
    |> Enum.map(& &1.direction)
  end

  def set_current_place!(pid) do
    current_pos = Position.get_current_position(pid)

    case @modules
         |> Map.values()
         |> Enum.filter(& &1.get_location() === current_pos)
         |> Enum.at(0, nil) do
      nil -> unset_current_place!(pid)
      module -> module.set_to_current!(pid)
    end
  end

  defp unset_current_place!(pid) do
    Settings.update_setting!(pid, :current_place, nil)
  end
end
