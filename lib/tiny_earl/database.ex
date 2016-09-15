defmodule TinyEarl.Database do
  @pool_size 3

  def start_link(db_folder) do
    TinyEarl.PoolSupervisor.start_link(db_folder, @pool_size)
  end

  def store(key, data) do
    key
    |> choose_worker
    |> TinyEarl.DatabaseWorker.store(key, data)
  end

  def get(key) do
    key
    |> choose_worker
    |> TinyEarl.DatabaseWorker.get(key)
  end

  def stop do
    GenServer.stop(:tiny_earl_db)
  end

  defp choose_worker(key) do
    :erlang.phash2(key, @pool_size) + 1
  end
end
