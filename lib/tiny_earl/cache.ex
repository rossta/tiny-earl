defmodule TinyEarl.Cache do
  use GenServer
  alias TinyEarl.{Server, Database}

  def start_link do
    # IO.puts "Starting tiny-earl cache"
    GenServer.start_link(__MODULE__, nil, name: :tiny_earl_cache)
  end

  def init(_) do
    Database.start_link("./data/#{Mix.env}")
    {:ok, %{}}
  end

  def server_process(domain_name) do
    GenServer.call(:tiny_earl_cache, {:server_process, domain_name})
  end

  def handle_call({:server_process, domain_name}, _from, servers) do
    case Map.fetch(servers, domain_name) do
      {:ok, server} ->
        {:reply, server, servers}
      :error ->
        {:ok, new_server} = Server.start_link(domain_name)
        {:reply, new_server, Map.put(servers, domain_name, new_server)}
    end
  end
end
