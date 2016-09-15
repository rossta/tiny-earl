defmodule TinyEarl.ServerSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil, name: :server_supervisor)
  end

  def start_child(domain_name) do
    Supervisor.start_child(:server_supervisor, [domain_name])
  end

  def init(_) do
    supervise([
      worker(TinyEarl.Server, [])
    ], strategy: :simple_one_for_one)
  end
end
