defmodule TinyEarl.ServerTest do
  use ExUnit.Case, async: true
  import TinyEarl.TestCleaner
  alias TinyEarl.{Database, Server}

  setup do
    Database.start("./data/test")
    on_exit fn -> cleanup end
  end

  test ".add_url adds a shortened link to link domain" do
    assert {:ok, pid} = Server.start("http://tiny.co")
    domain = Server.add_url(pid, "http://example.org")
    assert domain.entries |> Map.keys |> length == 1
    [link | _rest] = domain.entries |> Map.values
    assert link.url == "http://example.org"
  end

  test ".add_url stores link in database" do
    {:ok, pid} = Server.start("http://tiny.co")
    domain = Server.add_url(pid, "http://example.org")
    Server.stop(pid)

    {:ok, pid} = Server.start("http://tiny.co")
    [link] = Server.entries(pid) |> Map.values
    assert link.url == "http://example.org"
  end
end
