defmodule Ag.RoomsTest do
  use Ag.DataCase

  alias Ag.Areas.Rooms

  describe "set_current_room\2" do
    test "all rooms set", %{pid: pid} do
      Rooms.modules()
      |> Enum.map(fn {slug, _module} ->
        Rooms.set_current_room!(pid, slug)
        assert Rooms.get_current_room(pid) === slug
      end)
    end
  end
end
