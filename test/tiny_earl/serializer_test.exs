defmodule TinyEarl.SerializerTest do
  use ExUnit.Case
  alias TinyEarl.Serializer

  test "encodes numerical id to base 62 shortcode" do
    assert "cb" == TinyEarl.Serializer.encode(125)
    assert "e9a" == TinyEarl.Serializer.encode(19158)
  end

  test "decodes shortcode to numerical id" do
    assert 125 == TinyEarl.Serializer.decode("cb")
    assert 19158 == TinyEarl.Serializer.decode("e9a")
  end
end
