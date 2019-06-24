defmodule AgWeb.API.UserController do
  use AgWeb, :controller

  alias Ag.Users

  def show_or_create(conn, %{"email" => email}) do
    user = Users.get_or_create_user!(%{email_address: email})
    render(conn, "show.json", user: user)
  end
end
