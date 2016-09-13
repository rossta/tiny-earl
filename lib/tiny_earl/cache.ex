defmodule TinyEarl.Cache do
  use GenServer
  alias TinyEarl.Server

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def init(_) do
    {:ok, %{}}
  end

  def server_process(cache_pid, domain_name) do
    GenServer.call(cache_pid, {:server_process, domain_name})
  end

  def handle_call({:server_process, domain_name}, _from, servers) do
    case Map.fetch(servers, domain_name) do
      {:ok, server} ->
        {:reply, server, servers}
      :error ->
        {:ok, new_server} = Server.start
        {:reply, new_server, Map.put(servers, domain_name, new_server)}
    end
  end
end
