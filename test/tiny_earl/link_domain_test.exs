defmodule TinyEarl.LinkDomainTest do
  use ExUnit.Case
  alias TinyEarl.LinkDomain

  test ".new returns struct with name" do
    domain = LinkDomain.new("http://tiny.co")
    assert domain.name == "http://tiny.co"
    assert domain.entries == Map.new
  end

  test ".add_url adds a shortened link to link domain" do
    domain = LinkDomain.new("http://tiny.co")
    assert domain.entries |> Map.keys |> length == 0

    domain = LinkDomain.add_url(domain, "http://example.org")
    assert domain.entries |> Map.keys |> length == 1
    [link | _rest] = domain.entries |> Map.values
    assert link.url == "http://example.org"
  end
end
