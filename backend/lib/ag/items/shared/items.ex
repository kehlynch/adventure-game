defmodule Ag.Items.Item do
  @enforce_keys [:slug, :name, :desc, :options]
  defstruct slug: :init, name: :init, desc: :init, options: :init
end

defmodule Ag.Items do
  alias Ag.Settings

  @item_modules %{
    dagger: Ag.Items.Dagger,
    coins: Ag.Items.Coins,
    sword: Ag.Items.Sword,
    apple: Ag.Items.Apple,
    flowers: Ag.Items.Flowers
  }

  def init!(pid) do
    @item_modules
    |> Map.values()
    |> Enum.filter(& &1.starting_inv?())
    |> Enum.each(& &1.init!(pid))
  end

  def get_inventory(pid) do
    @item_modules
    |> Enum.filter(fn {_, module} -> module.inv?(pid) end)
    |> Keyword.values()
    |> Enum.map(& &1.get_item(pid))
  end

  def init_item(pid, slug) do
    Map.get(@item_modules, slug).init!(pid)
  end

  def add(pid, slug, count) do
    Map.get(@item_modules, slug).add(pid, count)
  end

  def apply_choice!(pid, %{area: slug, option: option}) do
    module = Map.get(@item_modules, slug)
    module.apply_choice!(pid, option)
  end

  def get_settings(pid, item_slug) do
    Settings.get_setting(pid, [:items, item_slug], %{})
  end

  def get_setting(pid, item_slug, setting, default \\ nil) do
    Settings.get_setting(pid, [:items, item_slug, setting], default)
  end

  def set_setting!(pid, item_slug, setting, value) do
    Settings.update_setting!(pid, [:items, item_slug], %{setting => value})
  end

  def increment_setting!(pid, item_slug, setting, value) do
    Settings.increment_setting!(pid, [:items, item_slug, setting], value)
  end
end
