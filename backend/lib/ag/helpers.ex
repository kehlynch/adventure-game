defmodule Ag.Helpers do
  def have_same_ids?(list1, list2) when is_list(list1) and is_list(list2) do
    get_sorted_ids(list1) == get_sorted_ids(list2)
  end

  defp get_sorted_ids(list) when is_list(list) do
    list
    |> Enum.map(&get_id(&1))
    |> Enum.sort()
  end

  defp get_id(%{} = struct) do
    Map.get(struct, :id) || Map.get(struct, "id")
  end

  def atomise(string) when is_binary(string) do
    String.to_atom(string)
  end

  def atomise(list) when is_list(list) do
    Enum.map(list, &atomise(&1))
  end

  def atomise(map) when is_map(map) do
    for {key, val} <- map, into: %{} do
      {atomise(key), atomise(val)}
    end
  end

  def atomise(unhandled), do: unhandled

  def get_direction(v1, v2) do
    {ns1, ew1} = v1
    {ns2, ew2} = v2
    distance_ns = ns2 - ns1
    distance_ew = ew2 - ew1

    case distance_ns
         |> Math.atan2(distance_ew)
         |> Math.rad2deg()
         |> Kernel./(45)
         |> Float.round() do
      0 -> :north
      1 -> :north_east
      2 -> :east
      3 -> :south_east
      4 -> :south
      5 -> :south_west
      6 -> :west
      7 -> :north_west
      8 -> :north
    end
  end

  def human_join(list) when is_list(list) do
    {last, rest} = List.pop_at(list, -1)
    "#{Enum.join(rest, ", ")} and #{last}"
  end
end
