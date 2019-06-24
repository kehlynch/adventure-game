defmodule Ag.Settings.Helpers do
  @moduledoc """
  https://gist.github.com/ifoo/334d11f4b7cb5491447d39539ebf85bb
  """

  def put_in(data, keys, value) do
    elem(kernel_get_and_update_in(data, keys, fn _ -> {nil, value} end), 1)
  end

  defp kernel_get_and_update_in(data, [head], fun) when is_function(head, 3),
    do: head.(:get_and_update, data, fun)

  defp kernel_get_and_update_in(data, [head | tail], fun) when is_function(head, 3),
    do: head.(:get_and_update, data, &kernel_get_and_update_in(&1, tail, fun))

  defp kernel_get_and_update_in(data, [head], fun) when is_function(fun, 1),
    do: access_get_and_update(data, head, fun)

  defp kernel_get_and_update_in(data, [head | tail], fun) when is_function(fun, 1),
    do: access_get_and_update(data, head, &kernel_get_and_update_in(&1, tail, fun))

  defp access_get_and_update(map, key, fun) when is_map(map) do
    Map.get_and_update(map, key, fun)
  end

  defp access_get_and_update(nil, key, fun) do
    m = Ag.Settings.Helpers.put_in(%{}, [key], elem(fun.(nil), 1))
    {nil, m}
  end
end
