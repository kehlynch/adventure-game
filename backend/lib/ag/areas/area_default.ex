defmodule Ag.Areas.Default do
  alias Ag.Settings
  alias Ag.Settings.{Position, Time}
  alias Ag.Areas.{Area, AreaBehaviour}
  alias Ag.Options.Option

  defmacro __using__(opts) do
    slug = Keyword.get(opts, :slug)
    type = Keyword.get(opts, :type, "Select")
    desc = Keyword.get(opts, :desc)
    options = Keyword.get(opts, :options, quote do: %{leave: "Leave"})


    quote do
      @behaviour AreaBehaviour
      @directions Position.directions()

      alias Ag.Places.Place

      @impl AreaBehaviour
      def get_area(pid) do
        %Area{
          slug: unquote(slug),
          type: get_type(pid),
          desc: get_desc(pid),
          options: get_options(pid)
        }
      end

      @impl AreaBehaviour
      def get_type(_pid), do: unquote(type)

      @impl AreaBehaviour
      def get_desc(_pid), do: unquote(desc)

      @imply AreaBehaviour
      def get_options(_pid) do
        unquote(options)
        |> Enum.map(fn {k, v} ->
          %Option{
            slug: k,
            text: v,
            direction: Enum.member?(@directions, k) && k,
            type: "Area"
          }
        end)
      end

      def get_direction_options(pid) do
        @directions
        |> Enum.map(&get_direction_option(pid, &1))
      end

      def get_direction_options(pid, ignore_direction) do
        @directions
        |> Enum.reject(&(&1 === ignore_direction))
        |> Enum.map(&get_direction_option(pid, &1))
      end

      defp get_direction_option(_pid, direction) do
        %Option{
          slug: direction,
          direction: direction,
          type: "Area",
          text: direction |> Atom.to_string |> String.capitalize()
        }
      end

      @impl AreaBehaviour
      def apply_choice!(pid, %{direction: d} = choice) when d in @directions do
        IO.puts("***")
        IO.puts("apply_choice!")
        Position.move!(pid, d, 1)
        Time.advance_time!(pid)
        dirname = Position.direction_name(d)
        "You go #{dirname} for an hour or so. Nothing interesting happens."
      end

      @impl AreaBehaviour
      def apply_choice!(_pid, _choice), do: nil

      def get_settings(pid) do
        Settings.get_setting(pid, [:areas, unquote(slug)], %{})
      end

      @impl AreaBehaviour
      def get_setting(pid, setting) do
        get_setting(pid, setting, nil)
      end

      @impl AreaBehaviour
      def get_setting(pid, setting, default) do
        Settings.get_setting(pid, [:areas, unquote(slug), setting], default)
      end

      @impl AreaBehaviour
      def set_setting!(pid, setting, value) do
        Settings.update_setting!(pid, [:areas, unquote(slug)], %{setting => value})
      end

      defoverridable AreaBehaviour
    end
  end
end
