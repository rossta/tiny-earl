# defmodule TinyEarl.DatabaseTest do
#   use ExUnit.Case, async: true
#   import TinyEarl.TestCleaner
#   alias TinyEarl.Database
#
#   setup do
#     Database.start({"./data/test", TinyEarl.FakeDatabaseWorker})
#
#     on_exit fn ->
#       cleanup
#       Database.start("./data/test")
#     end
#   end
#
#   test "pooling" do
#     assert(Database.store(1, :a) == Database.store(1, :a))
#     assert(Database.get(1) == Database.store(1, :a))
#     IO.puts "2: " <> inspect Database.store(2, :a)
#     IO.puts "1: " <> inspect Database.store(1, :a)
#     refute(Database.store(2, :a) == Database.store(1, :a))
#
#     on_exit fn -> Database.stop end
#   end
# end
