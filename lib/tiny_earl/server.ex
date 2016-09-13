defmodule TinyEarl.Server do
  use GenServer
  alias TinyEarl.LinkDomain

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_) do
    {:ok, LinkDomain.new("http://tiny.co")}
  end

  def add_url(server, url) do
    GenServer.call(server, {:add_url, url})
  end

  def handle_call({:add_url, url}, _from, state) do
    {:reply, LinkDomain.add_url(state, url), state}
  end
end
