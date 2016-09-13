defmodule TinyEarl.LinkDomain do
  alias TinyEarl.{LinkDomain, Link}

  defstruct name: nil, entries: Map.new

  def new(name), do: %LinkDomain{name: name}

  def add_url(%LinkDomain{entries: entries} = link_domain, url) do
    link = Link.shorten(url)
    new_entries = Map.put(entries, link.token, link)
    %LinkDomain{ link_domain | entries: new_entries }
  end
end
