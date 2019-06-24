defmodule Ag.ForestsTest do
  use Ag.DataCase

  alias Ag.{Areas, Games}
  alias Ag.Settings.Position
  alias Ag.Areas.Expanses.Forest

  describe "apply_choice!\2" do
    test "north from border goes to mountains", %{pid: pid} do
      Areas.set_current_area!(pid, :forest)
      Position.set_current_position!(pid, {10, 10})
      Forest.apply_choice!(pid, %{direction: :north})
      assert Position.get_current_position(pid) === {11, 10}
      assert Areas.get_current_area(pid) === :mountains
    end

    test "north from {10,1} goes to mountains", %{pid: pid} do
      Areas.set_current_area!(pid, :forest)
      Position.set_current_position!(pid, {10, 1})
      Forest.apply_choice!(pid, %{direction: :north})
      assert Position.get_current_position(pid) === {11, 1}
      assert Areas.get_current_area(pid) === :mountains
    end
  end
end
