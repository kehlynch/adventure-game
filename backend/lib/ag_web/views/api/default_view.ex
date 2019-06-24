defmodule AgWeb.API.DefaultView do
  use AgWeb, :view

  def render("status.json", %{status_code: status_code}) do
    %{message: to_string(status_code)}
  end
end
