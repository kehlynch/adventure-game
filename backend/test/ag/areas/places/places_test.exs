defmodule Ag.PlacesTest do
  use Ag.DataCase

  alias Ag.Areas.Places

  describe "set_current_place\2" do
    test "all places set", %{pid: pid} do
      Places.modules()
      |> Enum.map(fn {slug, _module} ->
        Places.set_current_place!(pid, slug)
        assert Places.get_current_place(pid) === slug
      end)
    end
  end
end
