defmodule AnneWeb.Api.LeavesController do
  use AnneWeb, :controller

  def index(conn, _params) do
    json(conn, %{id: 123, type: :holiday})
  end
end
