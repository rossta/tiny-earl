defmodule TinyEarl.SystemSupervisor do
  use Supervisor

  def init(_) do
    processes = [
      supervisor(TinyEarl.Database, ["./data/#{Mix.env}"]),
      supervisor(TinyEarl.ServerSupervisor, []),
      worker(TinyEarl.Cache, [])
    ]
    supervise(processes, strategy: :one_for_one)
  end

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end
end
