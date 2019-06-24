defmodule Ag.GamesTest do
  use Ag.DataCase

  alias Ag.Games

  describe "init_game!\0" do
    test "runs with new setup", %{pid: pid} do
      assert :ok === Games.init_game!(pid)
    end
  end
end
