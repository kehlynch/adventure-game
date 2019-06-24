defmodule Ag.Areas.Area do
  @enforce_keys [:slug, :desc, :type]
  defstruct slug: :init,
            desc: :init,
            type: :init,
            options: [],
            placeholder_text: nil
end

defmodule Ag.Areas do
  alias Ag.Areas.{Encounters, Expanses, Places, Rooms}

  defp get_module(slug) do
    get_module_lookup()
    |> Map.get(slug)
  end

  @doc """
  This is public for testing
  """
  def get_module_lookup() do
    Encounters.modules()
    |> Map.merge(Expanses.modules())
    |> Map.merge(Places.modules())
    |> Map.merge(Rooms.modules())
  end
    
  def get_area(pid) do
    module =
      pid
      |> get_current_area()
      |> get_module()
    module.get_area(pid)
  end

  def init!(pid) do
    Expanses.set_current_expanse!(pid, :forest)
  end

  def apply_choice!(pid, %{area: slug, option: option}) do
    module = get_module(slug)
    module.apply_choice!(pid, option)
  end

  def set_current_area!(pid, value) do
    get_module(value).set_to_current!(pid) 
  end

  def get_current_area(pid) do
    Rooms.get_current_room(pid) ||
      Places.get_current_place(pid) ||
        Expanses.get_current_expanse(pid)
  end

  def get_area_settings(pid, slug) do
    get_module(slug).get_settings(pid) 
  end

  def get_area_setting(pid, slug, setting, default \\ nil) do
    get_module(slug).get_setting(pid, setting, default) 
  end

  def get_current_area_setting(pid, setting, default \\ nil) do
    slug = get_current_area(pid)
    get_area_setting(pid, slug, setting, default)
  end

  def set_area_setting!(pid, slug, setting, value) do
    get_module(slug).set_setting!(pid, setting, value)
  end

  def set_current_area_setting!(pid, setting, value) do
    slug = get_current_area(pid)
    get_module(slug).set_setting!(pid, setting, value)
  end
end
