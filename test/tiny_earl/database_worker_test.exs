defmodule TinyEarl.DatabaseWorkerTest do
  use ExUnit.Case, async: false
  import TinyEarl.TestCleaner

  setup_all do
    TinyEarl.ProcessRegistry.start_link

    :ok
  end

  setup do
    worker_id = 1
    TinyEarl.DatabaseWorker.start_link("./data/test", worker_id)

    on_exit(fn ->
      cleanup
    end)

    {:ok, %{worker_id: worker_id}}
  end

  test "get and store", %{worker_id: worker_id} do
    TinyEarl.DatabaseWorker.store(worker_id, :a, {:some, "data"})
    TinyEarl.DatabaseWorker.store(worker_id, :b, {:another, ["data"]})

    assert({:some, "data"} == TinyEarl.DatabaseWorker.get(worker_id, :a))
    assert({:another, ["data"]} == TinyEarl.DatabaseWorker.get(worker_id, :b))
  end
end
