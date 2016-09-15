defmodule TinyEarl.Database do
  use GenServer

  def start_link({db_folder, worker}) do
    GenServer.start_link(__MODULE__, {db_folder, worker}, name: :tiny_earl_db)
  end

  def start_link(db_folder) do
    start_link({db_folder, TinyEarl.DatabaseWorker})
  end

  def store(key, data) do
    {pid, worker} = key |> choose_worker
    worker.store(pid, key, data)
  end

  def get(key) do
    {pid, worker} = key |> choose_worker
    worker.get(pid, key)
  end

  def stop do
    GenServer.stop(:tiny_earl_db)
  end

  def init({db_folder, worker}) do
    workers = (0..2)
      |> Enum.into(%{}, fn num ->
        {:ok, pid} = worker.start_link(db_folder)
        {num, {pid, worker}}
      end)

    {:ok, workers}
  end

  defp choose_worker(key) do
    GenServer.call(:tiny_earl_db, {:choose_worker, key})
  end

  def handle_call({:choose_worker, key}, _from, workers) do
    worker_key = :erlang.phash2(key, 3)
    {:reply, Map.get(workers, worker_key), workers}
  end
end
