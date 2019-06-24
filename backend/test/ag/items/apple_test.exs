defmodule Ag.ApplesTest do
  use Ag.DataCase

  alias Ag.Settings
  alias Ag.Settings.Status
  alias Ag.Items.Apple

  describe "apply_choice!\2" do
    test "eat", %{pid: pid} do
      Apple.set_setting!(pid, :count, 1)
      hunger = Status.get_hunger(pid)
      Apple.apply_choice!(pid, %{slug: :eat})
      new_hunger = Status.get_hunger(pid)
      assert hunger - 3 === new_hunger
      assert Apple.get_setting(pid, :count) === 0
    end

    test "drop", %{pid: pid} do
      Apple.set_setting!(pid, :count, 1)
      Apple.init!(pid)
      hunger = Status.get_hunger(pid)
      Apple.apply_choice!(pid, %{slug: :drop})
      new_hunger = Status.get_hunger(pid)
      assert hunger === new_hunger
      assert Apple.get_setting(pid, :count) === 0
    end
  end
end
