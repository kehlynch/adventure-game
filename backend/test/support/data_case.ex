defmodule Ag.DataCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Ag.DataCase
      import Ag.Factory
      import Ag.Repo.Factory, except: [build: 1]

      alias Ag.Repo
      alias Ag.{Games, Settings, Stores}
      alias Ag.Stores.Store

      setup do
        user = insert(:user)
        %Store{id: store_id} = Stores.create_store!(%{user_id: user.id})
        pid = Settings.start_link(store_id)
        Games.init_game!(pid)
        {:ok, pid: pid}
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ag.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Ag.Repo, {:shared, self()})
    end

    :ok
  end

  @doc """
  A helper that transform changeset errors to a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  def have_same_ids?(list1, list2) when is_list(list1) and is_list(list2) do
    get_sorted_ids(list1) == get_sorted_ids(list2)
  end

  defp get_sorted_ids(list) when is_list(list) do
    list
    |> Enum.map(&get_id(&1))
    |> Enum.sort()
  end

  defp get_id(struct = %{}) do
    Map.get(struct, :id) || Map.get(struct, "id")
  end
end
