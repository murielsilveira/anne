defmodule AnneWeb.DashboardController do
  use AnneWeb, :controller

  def index(conn, _params) do
    conn
    |> put_flash(:info, "hey overridden")
    |> put_flash(:info, "hey there")
    |> put_flash(:error, "uuups")
    |> render("index.html")
  end
end
