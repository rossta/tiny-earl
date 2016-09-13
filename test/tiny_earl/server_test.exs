defmodule TinyEarl.ServerTest do
  use ExUnit.Case
  alias TinyEarl.Server

  test "starting the server" do
    assert {:ok, _pid} = Server.start_link()
  end

  # test "shorten new url" do
  #   assert {:ok, pid} = Server.start_link()
  #   url = Server.shorten("http://example.org", 123)
  #   assert url == "ex"
  # end
end
