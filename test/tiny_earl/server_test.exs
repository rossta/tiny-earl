defmodule TinyEarl.ServerTest do
  use ExUnit.Case, async: true
  import Mock
  alias TinyEarl.{Server, LinkDomain}

  test ".add_url adds a shortened link to link domain" do
    with_mock TinyEarl.Database, [
      store: fn _, _ -> nil end,
      get: fn _ -> nil end] do
      assert {:ok, pid} = Server.start_link("http://tiny.co")
      domain = Server.add_url(pid, "http://example.org")
      assert domain.entries |> Map.keys |> length == 1
      [link | _rest] = domain.entries |> Map.values
      assert link.url == "http://example.org"
    end
  end

  test ".add_url stores link in database" do
    with_mock TinyEarl.Database, [
      store: fn _, _ -> nil end,
      get: fn _ -> %LinkDomain{entries: %{ "foo" => %{url: "http://example.org"}}} end] do
      {:ok, pid} = Server.start_link("http://tiny.co")
      Server.add_url(pid, "http://example.org")
      Server.stop(pid)

      {:ok, pid} = Server.start_link("http://tiny.co")
      [link] = Server.entries(pid) |> Map.values
      assert link.url == "http://example.org"
    end
  end
end
