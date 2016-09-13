defmodule TinyEarl.Server do
  use GenServer
  alias TinyEarl.LinkDomain

  def start do
    GenServer.start(__MODULE__, [])
  end

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_) do
    {:ok, LinkDomain.new("http://tiny.co")}
  end

  def add_url(server, url) do
    GenServer.call(server, {:add_url, url})
  end

  def entries(server) do
    GenServer.call(server, :entries)
  end

  def handle_call({:add_url, url}, _from, link_domain) do
    link_domain = LinkDomain.add_url(link_domain, url)
    {:reply, link_domain, link_domain}
  end

  def handle_call(:entries, _from, link_domain) do
    {:reply, LinkDomain.entries(link_domain), link_domain}
  end
end
