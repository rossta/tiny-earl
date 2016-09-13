defmodule TinyEarl.ServerTest do
  use ExUnit.Case
  alias TinyEarl.Server

  test "starting the server" do
    assert {:ok, _pid} = Server.start_link()
  end

  test ".add_url adds a shortened link to link domain" do
    assert {:ok, pid} = Server.start()
    domain = Server.add_url(pid, "http://example.org")
    assert domain.entries |> Map.keys |> length == 1
    [link | _rest] = domain.entries |> Map.values
    assert link.url == "http://example.org"
  end

  test "adding to one server does not affect entries of another" do
    assert {:ok, pid} = Server.start()
    domain = Server.add_url(pid, "http://example.org")
  end
end
