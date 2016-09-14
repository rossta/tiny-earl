defmodule TinyEarl.FakeDatabaseWorker do
  use GenServer

  def start(_) do
    GenServer.start(__MODULE__, nil)
  end

  def store(worker_pid, key, data) do
    GenServer.call(worker_pid, {:store, key, data})
  end

  def get(worker_pid, key) do
    GenServer.call(worker_pid, {:get, key})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:store, _, _}, _, state) do
    {:reply, self, state}
  end

  def handle_call({:get, _}, _, state) do
    {:reply, self, state}
  end

  # Needed for testing purposes
  def handle_info(:stop, state), do: {:stop, :normal, state}
  def handle_info(_, state), do: {:noreply, state}
end
