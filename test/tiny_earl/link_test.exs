defmodule TinyEarl.LinkTest do
  use ExUnit.Case
  alias TinyEarl.Link

  test "link struct has url, token, uuid" do
    link = %Link{url: "url", token: "token", uuid: 123}
    %Link{url: url, token: token, uuid: _uuid} = link
    assert url == "url"
    assert token == "token"
  end

  test ".shorten produces a new token and uuid from url" do
    link = Link.shorten("http://example.org")
    assert link.url == "http://example.org"
    assert String.length(link.token) < 7, "Expected link token to be six characters or less"
    assert Regex.match?(~r/[A-Za-z0-9]+/, link.token), "Expected link token to be letters and numbers only"
    assert is_integer(link.uuid), "Expected link uuid to be an integer"
  end
end
