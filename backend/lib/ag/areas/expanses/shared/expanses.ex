defmodule Ag.Areas.Expanses do
  alias Ag.Settings
  alias Ag.Settings.Position
  alias Ag.Areas.Expanses

  @modules %{
    forest: Expanses.Forest,
    mountains: Expanses.Mountains
  }

  defp get_module(slug), do: Map.get(@modules, slug)

  def modules(), do: @modules

  def get_current_expanse(pid) do
    Settings.get_setting(pid, :current_expanse)
  end

  def set_current_expanse!(pid, value) do
    get_module(value).set_to_current!(pid) 
  end

  def set_current_expanse!(pid) do
    {ns, ew} = Position.get_current_position(pid)
    slug =
      case @modules
           |> Enum.filter(fn {_slug, module} ->
             {n, e, s, w} = module.get_boundaries()
             (ns in n..s) && (ew in e..w)
           end)
           |> Keyword.keys() do
        slugs when length(slugs) === 1 -> Enum.at(slugs, 0)
        slugs when length(slugs) === 0 -> raise "no expanse found for {#{ns}, #{ew}"
        _ -> raise "multiple expanse found for {#{ns}, #{ew}}"
      end
    Map.get(@modules, slug).set_to_current!(pid)
  end
end
