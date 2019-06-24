defmodule Ag.Weathers.Default do
  alias Ag.{Areas, Weathers}
  alias Ag.Weathers.WeatherBehaviour
  alias Ag.Options.Option
  defmacro __using__(opts) do
    slug = Keyword.get(opts, :slug)
    name = Keyword.get(opts, :name)

    quote do
      @behaviour WeatherBehaviour

      @impl WeatherBehaviour
      def get_desc(pid) do
        module = 
          pid
          |> get_current_weather()
          |> get_module()

        module.get_desc(pid)

        weather = get_current_weather(pid)
        previous = get_previous_weather(pid)
        tod = Time.get_time_of_day_name(pid)
        get_desc(weather, previous, tod)
      end

      defp get_desc(c, p, t) when c === p do
        "It is #{t} and it is still #{p}"
      end

      defp get_desc(c, p, t) do
        "It is #{t}; it has stopped #{p} and started #{p}"
      end

      def get_current_weather(pid) do
        pid
        |> get_weather_list()
        |> hd()
      end

      @impl WeatherBehaviour 
      def get_name(_pid), do: unquote(name)
      
      @impl WeatherBehaviour
      def set_to_current!(pid) do
        weather_list = [unquote(slug)] ++ get_weather_list(pid)

        pid
        |> Settings.update_setting!(:weather, weather_list)
      end

      defp get_weather_list(pid) do
        pid
        |> Settings.get_setting(:weather, [])
      end

      defoverridable WeatherBehaviour
    end
  end
end
