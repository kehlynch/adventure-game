defmodule Ag.Expanses.Default do
  import Ag.Helpers
  alias Ag.Settings
  alias Ag.Expanses.ExpanseBehaviour
  alias Ag.Areas.AreaBehaviour
  alias Ag.Areas.{Expanses, Places}
  alias Ag.Settings.Position

  defmacro __using__(opts) do
    slug = Keyword.get(opts, :slug)
    desc = Keyword.get(opts, :desc)
    type = Keyword.get(opts, :type, "Select")
    boundaries = Keyword.get(opts, :boundaries)
    path_desc = Keyword.get(opts, :path_desc)

    quote do
      @behaviour ExpanseBehaviour
      @behaviour AreaBehaviour

      @directions Position.directions()

      use Ag.Areas.Default,
        slug: unquote(slug),
        type: unquote(type),
        desc: unquote(desc)

      def get_boundaries(), do: unquote(boundaries)

      @impl ExpanseBehaviour
      def init(_pid), do: nil

      @impl AreaBehaviour
      def set_to_current!(pid) do
        Settings.update_setting!(pid, :current_expanse, unquote(slug))
      end

      @impl AreaBehaviour
      def get_area(pid) do
        init(pid)
        super(pid)
      end

      @impl AreaBehaviour
      def apply_choice!(pid, %{direction: dir} = choice) when dir in @directions do
        message = super(pid, choice)
        # TODO make message say where you've gone
        Places.set_current_place!(pid)
        Expanses.set_current_expanse!(pid)
        message
      end

      @impl ExpanseBehaviour
      def get_exits_desc(pid) do
        taken_dirs = Places.get_entry_dirs(pid)
        directions =
          Position.directions()
          |> Enum.reject(&Enum.member?(taken_dirs, &1))

        "To your #{human_join(directions)} #{unquote(path_desc)}"
      end

      @impl AreaBehaviour
      def get_options(pid) do
        entry_options = Places.get_entry_options(pid)
        dir_options = get_dir_options(pid, entry_options)
        entry_options ++ dir_options
      end


      def get_dir_options(pid, options) do
        taken_dirs = Enum.map(options, & &1.direction)

        Position.directions()
        |> Enum.reject(&Enum.member?(taken_dirs, &1))
        |> Enum.map(& get_direction_option(pid, &1))
      end

      @impl AreaBehaviour
      def get_setting(pid, setting) do
        get_setting(pid, setting, nil)
      end

      @impl AreaBehaviour
      def get_setting(pid, setting, default) do
        Position.get_current_position_setting(pid, setting, default)
      end

      @impl AreaBehaviour
      def set_setting!(pid, setting, value) do
        Position.set_current_position_setting!(pid, setting, value)
      end

      defoverridable ExpanseBehaviour
      defoverridable AreaBehaviour
    end
  end
end
