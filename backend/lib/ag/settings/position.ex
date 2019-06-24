defmodule Ag.Settings.Position do
  alias Ag.Settings

  @directions [:north, :south, :east, :west]

  def init!(pid) do
    set_current_position!(pid, {0, 0})
  end
  
  def directions(), do: @directions

  def direction_name(direction) do
    direction
    |> Atom.to_string()
    |> String.replace("_", " ")
  end

  def get_distance_direction(pid, position) do
    current_position =
      pid
      |> get_current_position()

    direction =
      current_position
      |> get_direction(position)

    distance =
      current_position
      |> get_distance(position)

    {distance, direction, direction_name(direction)}
  end

  defp get_distance(current_position, position) do
    current_position
    |> Distance.distance(position)
  end

  defp get_direction(current_position, position) do
    {ns1, ew1} = current_position
    {ns2, ew2} = position
    distance_ns = ns2 - ns1
    distance_ew = ew2 - ew1

    case distance_ew
         |> Math.atan2(distance_ns)
         |> Math.rad2deg()
         |> Kernel./(45)
         |> Float.round()
         |> trunc() do
      0 -> :north
      1 -> :north_east
      2 -> :east
      3 -> :south_east
      4 -> :south
      -4 -> :south
      -3 -> :south_west
      -2 -> :west
      -1 -> :north_west
    end
  end

  def move!(pid, :north, distance) do
    do_move!(pid, distance, 0)
  end

  def move!(pid, :south, distance) do
    do_move!(pid, -distance, 0)
  end

  def move!(pid, :east, distance) do
    do_move!(pid, 0, distance)
  end

  def move!(pid, :west, distance) do
    do_move!(pid, 0, -distance)
  end

  defp do_move!(pid, ns, ew) do
    {old_ns, old_ew} = get_current_position(pid)
    new_position = {old_ns + ns, old_ew + ew}
    set_current_position!(pid, new_position)
  end

  defp get_current_position_settings(pid) do
    cl_str =
      pid
      |> get_current_position_str()

    pid
    |> Settings.get_setting([:positions, cl_str])
  end

  defp set_current_position_settings!(pid, settings) do
    cl_str =
      pid
      |> get_current_position_str()

    pid
    |> Settings.update_setting!([:positions, cl_str], settings)
  end

  def get_current_position_setting(pid, setting, default \\ nil) do
    cl_str =
      pid
      |> get_current_position_str()

    pid
    |> Settings.get_setting([:positions, cl_str, setting], default)
  end

  def set_current_position_setting!(pid, setting, value) do
    old_settings = get_current_position_settings(pid)

    settings =
      case old_settings do
        nil -> %{setting => value}
        %{} -> Map.put(old_settings, setting, value)
      end

    set_current_position_settings!(pid, settings)
  end

  def set_current_position!(pid, position) when is_tuple(position) do
    set_current_position!(pid, Tuple.to_list(position))
  end

  def set_current_position!(pid, position) do
    pid
    |> Settings.update_setting!(:position, position)
  end

  def get_current_position(pid) do
    pid
    |> Settings.get_setting(:position)
    |> List.to_tuple()
  end

  defp get_current_position_str(pid) do
    pid
    |> get_current_position()
    |> position_to_s()
  end

  defp position_to_s({ns, ew}) do
    "#{ns}_#{ew}"
  end
end
