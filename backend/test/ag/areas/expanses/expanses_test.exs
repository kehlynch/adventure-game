defmodule Ag.ExpansesTest do
  use Ag.DataCase

  alias Ag.Areas.Expanses

  describe "get_current_expanse\1" do
    test "returns forest for new game", %{pid: pid} do
      assert Expanses.get_current_expanse(pid) === :forest
    end
  end

  describe "set_current_expanse\2" do
    test "all expanses set", %{pid: pid} do
      Expanses.modules()
      |> Enum.map(fn {slug, _module} ->
        Expanses.set_current_expanse!(pid, slug)
        assert Expanses.get_current_expanse(pid) === slug
      end)
    end
  end
end
