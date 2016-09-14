defmodule TinyEarl.ServerTest do
  use ExUnit.Case, async: false
  alias TinyEarl.{Database, Server}

  setup do
    Database.start("./data/test")

    on_exit fn ->
      File.rm_rf!("./data/test")
      send(:tiny_earl_db, :stop)
    end
  end

  test ".add_url adds a shortened link to link domain" do
    assert {:ok, pid} = Server.start("http://tiny.co")
    domain = Server.add_url(pid, "http://example.org")
    assert domain.entries |> Map.keys |> length == 1
    [link | _rest] = domain.entries |> Map.values
    assert link.url == "http://example.org"
  end
end
