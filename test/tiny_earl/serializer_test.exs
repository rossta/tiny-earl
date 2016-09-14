defmodule TinyEarl.SerializerTest do
  use ExUnit.Case
  alias TinyEarl.Serializer

  test "encodes numerical id to base 62 shortcode" do
    assert "cb" == Serializer.encode(125)
    assert "e9a" == Serializer.encode(19158)
  end

  test "decodes shortcode to numerical id" do
    assert 125 == Serializer.decode("cb")
    assert 19158 == Serializer.decode("e9a")
  end
end
