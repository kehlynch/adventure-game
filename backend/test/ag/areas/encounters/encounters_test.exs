defmodule Ag.EncountersTest do
  use Ag.DataCase

  alias Ag.Areas.Encounters

  describe "set_current_encounter\2" do
    test "all encounters set", %{pid: pid} do
      Encounters.modules()
      |> Enum.map(fn {slug, _module} ->
        Encounters.set_current_encounter!(pid, slug)
        assert Encounters.get_current_encounter(pid) === slug
      end)
    end
  end
end
