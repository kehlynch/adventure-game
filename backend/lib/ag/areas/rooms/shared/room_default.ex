defmodule Ag.Areas.Rooms.Default do
  alias Ag.Areas.AreaBehaviour
  alias Ag.Settings

  defmacro __using__(opts) do
    slug = Keyword.get(opts, :slug)
    type = Keyword.get(opts, :type, "Select")
    desc = Keyword.get(opts, :desc)
    options = Keyword.get(opts, :options)


    quote do
      @behaviour AreaBehaviour

      use Ag.Areas.Default,
        slug: unquote(slug),
        type: unquote(type),
        desc: unquote(desc),
        options: unquote(options)

      @impl AreaBehaviour
      def set_to_current!(pid) do
        Settings.update_setting!(pid, :current_room, unquote(slug))
      end

      # defoverridable RoomBehaviour
      defoverridable AreaBehaviour
    end
  end
end
