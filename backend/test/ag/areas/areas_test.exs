defmodule Ag.AreasTest do
  use Ag.DataCase

  alias Ag.Areas
  alias Ag.Areas.Area

  describe "get_area\1" do
    test "returns forest for new game", %{pid: pid} do
      assert %Area{slug: :forest} = Areas.get_area(pid)
    end
  end
end
