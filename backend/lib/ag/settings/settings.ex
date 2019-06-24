defmodule Ag.Settings do
  use GenServer
  import Ag.Helpers

  alias Ag.Stores
  alias Ag.Settings.Helpers

  # GenServer callbacks

  def init(store_id) do
    {:ok, Stores.get_store!(store_id)}
  end

  def handle_call({:get, path, default}, _from, store) when is_list(path) do
    value =
      store
      |> Stores.get_settings()
      |> get_in(atomise(path))
    case value do
      nil -> {:reply, default, store}
      result -> {:reply, result, store}
    end
  end

  def handle_call({:get, path, default}, _from, store) do
    result =
      store
      |> Stores.get_settings()
      |> Map.get(path, default)
    {:reply, result, store}
  end

  def handle_cast({:set, path, value}, store) when is_list(path) do
    settings =
      store
      |> Stores.get_settings()
      |> Helpers.put_in(atomise(path), atomise(value))

    store = Stores.update_store!(store, %{data: settings})
    {:noreply, store}
  end

  def handle_cast({:set, path, value}, store) do
    settings =
      store
      |> Stores.get_settings()
      |> Map.put(path, value)

    store = Stores.update_store!(store, %{data: settings})
    {:noreply, store}
  end

  ### API
  
  def start_link(store_id) do
    {:ok, pid} = GenServer.start_link(__MODULE__, store_id)
    pid
  end

  def get_setting(pid, path, default \\ nil) do
    GenServer.call(pid, {:get, path, default})
  end

  def update_setting!(pid, path, value) when is_map(value) do
    new_value =
      pid
      |> get_setting(path, %{})
      |> Map.merge(value)

    GenServer.cast(pid, {:set, path, new_value})
  end

  def update_setting!(pid, path, value) do
    GenServer.cast(pid, {:set, path, value})
  end

  def increment_setting!(pid, path, value) when is_number(value) do
    new_value =
      pid
      |> get_setting(path, 0)
      |> Kernel.+(value)

    GenServer.cast(pid, {:set, path, new_value})
  end
end
