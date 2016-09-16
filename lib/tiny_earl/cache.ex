defmodule TinyEarl.Cache do
  use GenServer
  alias TinyEarl.{Server, ServerSupervisor}

  def start_link do
    IO.puts "Starting tiny-earl cache"
    GenServer.start_link(__MODULE__, nil, name: :tiny_earl_cache)
  end

  def stop do
    GenServer.stop(:tiny_earl_cache)
  end

  def init(_) do
    {:ok, nil}
  end

  def server_process(domain_name) do
    case Server.whereis(domain_name) do
      :undefined ->
        GenServer.call(:tiny_earl_cache, {:server_process, domain_name})

      pid -> pid
    end
  end

  def handle_call({:server_process, domain_name}, _from, state) do
    server_pid = case Server.whereis(domain_name) do
      :undefined ->
        {:ok, pid} = ServerSupervisor.start_child(domain_name)
        pid

      pid -> pid
    end
    {:reply, server_pid, state}
  end
end
