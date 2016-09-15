defmodule TinyEarl.DatabaseWorkerTest do
  use ExUnit.Case, async: false
  import TinyEarl.TestCleaner

  setup do
    {:ok, worker} = TinyEarl.DatabaseWorker.start_link("./data/test")

    on_exit(fn ->
      cleanup
    end)

    {:ok, worker: worker}
  end

  test "get and store", %{worker: worker} do
    assert(nil == TinyEarl.DatabaseWorker.get(worker, 1))

    TinyEarl.DatabaseWorker.store(worker, 1, {:some, "data"})
    TinyEarl.DatabaseWorker.store(worker, 2, {:another, ["data"]})

    assert({:some, "data"} == TinyEarl.DatabaseWorker.get(worker, 1))
    assert({:another, ["data"]} == TinyEarl.DatabaseWorker.get(worker, 2))
  end
end
