defmodule AgWeb.API.FallbackController do
  use AgWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{}}), do: do_call(conn, :unprocessable_entity)
  def call(conn, {:error, _, %Ecto.Changeset{}, _}), do: do_call(conn, :unprocessable_entity)
  def call(conn, {:error, status_code}), do: do_call(conn, status_code)
  def call(conn, {:ok, status_code}), do: do_call(conn, status_code)

  def call(conn, x) do
    IO.inspect(x)
    do_call(conn, :internal_server_error)
  end

  defp do_call(conn, status_code) do
    conn
    |> put_status(status_code)
    |> render(AgWeb.API.DefaultView, "status.json", status_code: status_code)
  end
end
