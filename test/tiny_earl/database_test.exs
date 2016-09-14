defmodule TinyEarl.DatabaseTest do
  use ExUnit.Case, async: false
  alias TinyEarl.Database

  setup do
    Database.start({"./data/test", TinyEarl.FakeDatabaseWorker})

    on_exit fn ->
      send(:tiny_earl_db, :stop)
    end
  end

  test "pooling" do
    assert(Database.store(1, :a) == Database.store(1, :a))
    assert(Database.get(1) == Database.store(1, :a))
    refute(Database.store(2, :a) == Database.store(1, :a))
  end
end
