defmodule TinyEarl.Supervisor do
  use Supervisor

  def init(_) do
    processes = [
      worker(TinyEarl.ProcessRegistry, []),
      supervisor(TinyEarl.SystemSupervisor, [])
    ]
    supervise(processes, strategy: :rest_for_one)
  end

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end
end
