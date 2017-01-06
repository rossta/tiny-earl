defmodule TinyEarl.Server do
  use GenServer
  alias TinyEarl.{Database, LinkDomain}

  def start_link(domain_name) do
    GenServer.start_link(__MODULE__, domain_name, name: via_tuple(domain_name))
  end

  def stop(server) do
    GenServer.stop(server)
  end

  def init(domain_name) do
    {:ok, {domain_name, Database.get(domain_name) || LinkDomain.new(domain_name)}}
  end

  def add_url(server, url) do
    GenServer.call(server, {:add_url, url})
  end

  def entries(server) do
    GenServer.call(server, :entries)
  end

  def whereis(domain_name) do
    :gproc.whereis_name({:n, :l, {:tiny_earl_server, domain_name}})
  end

  def handle_call({:add_url, url}, _from, {domain_name, link_domain}) do
    link_domain = LinkDomain.add_url(link_domain, url)
    Database.store(domain_name, link_domain)
    {:reply, link_domain, {domain_name, link_domain}}
  end

  def handle_call(:entries, _from, {domain_name, link_domain}) do
    {:reply, LinkDomain.entries(link_domain), {domain_name, link_domain}}
  end

  defp via_tuple(domain_name) do
    {:via, :gproc, {:n, :l, {:tiny_earl_server, domain_name}}}
  end
end
