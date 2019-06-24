defmodule Ag.ItemsTest do
  use Ag.DataCase

  alias Ag.Items

  describe "get_inventory\1" do
    test "gets init inventory items", %{pid: pid} do
      item_slugs =
        Items.get_inventory(pid)
        |> Enum.map(&(&1.slug))
        |> Enum.sort()
      assert [:coins, :dagger] === item_slugs
    end
  end
end
