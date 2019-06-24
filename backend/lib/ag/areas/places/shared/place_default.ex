defmodule Ag.Places.Default do
  alias Ag.Settings
  alias Ag.Areas.AreaBehaviour
  alias Ag.Places.PlaceBehaviour
  alias Ag.Settings.Position
  alias Ag.Options.Option

  defmacro __using__(opts) do
    slug = Keyword.get(opts, :slug)
    type = Keyword.get(opts, :type, "Select")
    desc = Keyword.get(opts, :desc)
    options = Keyword.get(opts, :options)
    entry_option_text = Keyword.get(opts, :entry_option)
    remote_desc_text = Keyword.get(opts, :remote_desc_text)
    location = Keyword.get(opts, :location)


    quote do
      @behaviour AreaBehaviour
      @behaviour PlaceBehaviour

      @directions [:north, :south, :east, :west]

      use Ag.Areas.Default,
        slug: unquote(slug),
        type: unquote(type),
        desc: unquote(desc),
        options: unquote(options)

      alias Ag.Places.Place

      def get_location(), do: unquote(location)

      @impl AreaBehaviour
      def set_to_current!(pid) do
        Settings.update_setting!(pid, :current_place, unquote(slug))
      end

      @impl PlaceBehaviour
      def get_entry_option(pid) do
        {distance, direction, direction_name} = Position.get_distance_direction(pid, unquote(location))

        case Position.get_distance_direction(pid, unquote(location)) do
          {dist, dir, _name} when dist === 1.0 ->
            %Option{
              slug: unquote(slug),
              direction: dir,
              text: unquote(entry_option_text),
              type: "Area"
            }
          _ -> nil
        end
      end

      @impl PlaceBehaviour
      def get_remote_desc(pid) do
        {distance, _direction, direction_name} = Position.get_distance_direction(pid, unquote(location))

        remote_desc_text = unquote(remote_desc_text)

        cond do
          # too far away to see
          distance > 10 ->
            nil

          # visible
          distance > 6 ->
            "In the distance to the #{direction_name} you see #{remote_desc_text}"

          distance > 4 ->
            "Some way away to the #{direction_name} you see #{remote_desc_text}"

          distance > 1 ->
            "Nearby to your #{direction_name} you see #{remote_desc_text}"

          trunc(distance) == 1 ->
            "To the #{direction_name} is #{remote_desc_text}"

          # if distance is 0 you are in the town
          true ->
            nil
        end
      end

      defoverridable PlaceBehaviour
      defoverridable AreaBehaviour
    end
  end
end
