defmodule TinyEarl.CacheTest do
  use ExUnit.Case
  alias TinyEarl.{Cache, Server}

  test ".server_process returns pid of server by name" do
    {:ok, cache} = Cache.start
    server_pid = Cache.server_process(cache, "http://tiny.co")
    repeat_server_pid = Cache.server_process(cache, "http://tiny.co")
    another_server_pid = Cache.server_process(cache, "http://bit.ly")

    assert server_pid == repeat_server_pid
    refute server_pid == another_server_pid
  end

  test "adding to one server does not affect entries of another" do
    {:ok, cache} = Cache.start
    tiny_domain = Cache.server_process(cache, "http://tiny.co")
    puny_domain = Cache.server_process(cache, "http://puny.ly")
    Server.add_url(tiny_domain, "http://foo.com/123")
    [link] = Server.entries(tiny_domain) |> Map.values

    assert link.url == "http://foo.com/123"
    assert Server.entries(tiny_domain) |> Map.values |> length == 1
    assert Server.entries(puny_domain) |> Map.values |> length == 0
  end
end
