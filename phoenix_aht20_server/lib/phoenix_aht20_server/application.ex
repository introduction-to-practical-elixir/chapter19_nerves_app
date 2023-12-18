defmodule PhoenixAht20Server.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixAht20ServerWeb.Telemetry,
      PhoenixAht20Server.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_aht20_server, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixAht20Server.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixAht20Server.Finch},
      # Start a worker by calling: PhoenixAht20Server.Worker.start_link(arg)
      # {PhoenixAht20Server.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixAht20ServerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixAht20Server.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixAht20ServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
