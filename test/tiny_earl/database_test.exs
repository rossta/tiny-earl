defmodule TinyEarl.DatabaseTest do
  use ExUnit.Case
  alias TinyEarl.Database

  test ".store stores data for given key for retrieval" do
    Database.store("foo", %{bar: "baz"})
    data = Database.get("foo")
    assert data == %{bar: "baz"}
  end

  test ".get returns nil if not stored" do
    assert Database.get("foz") == nil
  end
end
