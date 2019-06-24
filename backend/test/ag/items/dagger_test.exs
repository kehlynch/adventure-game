defmodule Ag.DaggerTest do
  use Ag.DataCase

  alias Ag.Items.Dagger

  describe "apply_choice!\2" do
    test "drop", %{pid: pid} do
      assert Dagger.get_setting(pid, :inventory)
      Dagger.apply_choice!(pid, %{slug: :drop})
      refute Dagger.get_setting(pid, :inventory)
    end
  end
end
