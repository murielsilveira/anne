defmodule AnneWeb.DashboardController do
  use AnneWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
