defmodule AnneWeb.Router do
  use AnneWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AnneWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AnneWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AnneWeb do
    pipe_through :browser

    live "/", PageLive, :index
    get "/dashboard", DashboardController, :index
    resources "/users", UserController
    resources "/session", SessionController, only: [:new, :create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  scope "/api", AnneWeb.Api, as: :api do
    pipe_through :api

    get "/leaves", LeavesController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/telemetry", metrics: AnneWeb.Telemetry
    end
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, Anne.Accounts.get_user!(user_id))
    end
  end
end
