defmodule TinyEarl.ServerTest do
  use ExUnit.Case
  alias TinyEarl.{Database, Server}

  test ".add_url adds a shortened link to link domain" do
    assert {:ok, pid} = Server.start("http://tiny.co")
    domain = Server.add_url(pid, "http://example.org")
    assert domain.entries |> Map.keys |> length == 1
    [link | _rest] = domain.entries |> Map.values
    assert link.url == "http://example.org"
  end
end
