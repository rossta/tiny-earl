defmodule TinyEarl.CacheTest do
  use ExUnit.Case, async: false
  import Mock
  alias TinyEarl.{Cache, Server}

  setup_all do
    TinyEarl.ProcessRegistry.start_link
    TinyEarl.ServerSupervisor.start_link

    :ok
  end

  test ".server_process returns pid of server by name" do
    with_mock TinyEarl.Database, [
      store: fn _, _ -> nil end,
      get: fn _ -> nil end] do
      {:ok, _cache} = Cache.start_link
      server_pid = Cache.server_process("http://tiny.co")
      repeat_server_pid = Cache.server_process("http://tiny.co")
      another_server_pid = Cache.server_process("http://bit.ly")

      assert server_pid == repeat_server_pid
      refute server_pid == another_server_pid
    end
  end

  test "adding to one server does not affect entries of another" do
    with_mock TinyEarl.Database, [
      store: fn _, _ -> nil end,
      get: fn _ -> nil end] do
      {:ok, _cache} = Cache.start_link
      tiny_domain = Cache.server_process("http://tiny.co")
      puny_domain = Cache.server_process("http://puny.ly")
      Server.add_url(tiny_domain, "http://foo.com/123")
      [link] = Server.entries(tiny_domain) |> Map.values

      assert link.url == "http://foo.com/123"
      assert Server.entries(tiny_domain) |> Map.values |> length == 1
      assert Server.entries(puny_domain) |> Map.values |> length == 0
    end
  end
end
