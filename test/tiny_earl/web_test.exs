defmodule TinyEarl.WebTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias TinyEarl.Web
  @opts Web.init([])

  test "post /add_url stores link in database" do
    conn = conn(:post, "/add_url", %{url: "http://example.org/123"})
           |> Web.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200

    entries = TinyEarl.Cache.server_process("http://localhost:5454")
              |> TinyEarl.Server.entries

    assert entries |> Map.keys |> length == 1
    [link | _rest] = entries |> Map.values
    assert link.url == "http://example.org/123"
  end

  test "post /add_url handles missing url" do
    conn = conn(:post, "/add_url", %{})
           |> Web.call(@opts)

    assert conn.state == :sent
    assert conn.status == 422
  end
end
