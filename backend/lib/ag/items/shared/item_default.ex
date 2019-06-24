defmodule Ag.Items.Default do
  alias Ag.{Areas, Items}
  alias Ag.Items.ItemBehaviour
  alias Ag.Options.Option
  defmacro __using__(opts) do
    slug = Keyword.get(opts, :slug)
    name = Keyword.get(opts, :name)
    desc = Keyword.get(opts, :desc)
    options = Keyword.get(opts, :options, quote do: %{drop: "Drop"})
    starting_inv = Keyword.get(opts, :starting_inv, false)
    stack = Keyword.get(opts, :stack, false)

    quote do
      @behaviour ItemBehaviour

      alias Ag.Items.Item

      @impl ItemBehaviour
      def starting_inv?(), do: unquote(starting_inv)

      @impl ItemBehaviour
      def inv?(pid) do
        if unquote(stack) do
          get_setting(pid, :count, 0) > 0
        else
          get_setting(pid, :inventory)
        end
      end

      @impl ItemBehaviour
      def init!(pid) do
        set_setting!(pid, :inventory, true)
        if unquote(stack), do: set_setting!(pid, :count, 1)
      end

      @impl ItemBehaviour
      def get_item(pid) do
        %Item{
          slug: unquote(slug),
          name: get_name(pid),
          desc: get_desc(pid),
          options: get_options(pid)
        }
      end

      @imply ItemBehaviour
      def get_options(_pid) do
        unquote(options)
        |> Enum.map(fn {k, v} ->
          %Option{
            slug: k,
            text: v,
            type: "Item"
          }
        end)
      end

      @impl ItemBehaviour 
      def get_name(_pid), do: unquote(name)

      @impl ItemBehaviour 
      def get_desc(_pid), do: unquote(desc)

      @impl ItemBehaviour
      def apply_choice!(pid, %{slug: :drop}) do
        set_setting!(pid, :inventory, false)
        Areas.set_current_area_setting!(pid, :items, %{unquote(slug) => true})
        "You drop #{unquote(name)}"
      end

      # @impl ItemBehaviour
      # def apply_choice!(_pid, _choice), do: nil

      @impl ItemBehaviour
      def get_settings(pid) do
        Items.get_settings(pid, unquote(slug))
      end

      @impl ItemBehaviour
      def get_setting(pid, setting) do
        get_setting(pid, setting, nil)
      end

      @impl ItemBehaviour
      def get_setting(pid, setting, default) do
        Items.get_setting(pid, unquote(slug), setting, default)
      end

      @impl ItemBehaviour
      def set_setting!(pid, setting, value) do
        Items.set_setting!(pid, unquote(slug), setting, value)
      end

      @impl ItemBehaviour
      def increment_setting!(pid, setting, value) do
        Items.increment_setting!(pid, unquote(slug), setting, value)
      end

      @impl ItemBehaviour
      def add(pid, number) do
        increment_setting!(pid, :count, number)
      end
      
      defoverridable ItemBehaviour
    end
  end
end
