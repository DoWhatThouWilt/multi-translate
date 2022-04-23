defmodule MultipleSelect.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      MultipleSelect.Repo,
      # Start the Telemetry supervisor
      MultipleSelectWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MultipleSelect.PubSub},
      # Start the Endpoint (http/https)
      MultipleSelectWeb.Endpoint,
      # Start a worker by calling: MultipleSelect.Worker.start_link(arg)
      # {MultipleSelect.Worker, arg}
      :poolboy.child_spec(:worker, python_poolboy_config())
      # Starts a worker by calling: Translator.Worker.start_link(arg)
      # {Translator.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MultipleSelect.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp python_poolboy_config do
    [
      {:name, {:local, :python_worker}},
      {:worker_module, Translator.PythonWorker},
      {:size, 12},
      {:max_overflow, 6}
    ]
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MultipleSelectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
