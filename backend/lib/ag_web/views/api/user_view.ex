defmodule AgWeb.API.UserView do
  use AgWeb, :view

  alias Ag.Users.User

  def render("show.json", %{user: %User{} = user}) do
    Map.new()
    |> Map.put(:id, user.id)
  end
end
