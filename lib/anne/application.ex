defmodule Anne.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Anne.Repo,
      # Start the Telemetry supervisor
      AnneWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Anne.PubSub},
      # Start the Endpoint (http/https)
      AnneWeb.Endpoint
      # Start a worker by calling: Anne.Worker.start_link(arg)
      # {Anne.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Anne.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AnneWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
