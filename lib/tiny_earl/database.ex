defmodule TinyEarl.Database do
  use GenServer

  def start(db_folder) do
    GenServer.start(__MODULE__, db_folder, name: :tiny_earl_db)
  end

  def stop do
    GenServer.stop(:tiny_earl_db)
  end

  def store(key, data) do
    GenServer.call(:tiny_earl_db, {:store, key, data})
  end

  def get(key) do
    GenServer.call(:tiny_earl_db, {:get, key})
  end

  def init(db_folder) do
    File.mkdir_p("#{db_folder}")
    {:ok, db_folder}
  end

  def handle_call({:get, key}, _from, db_folder) do
    data = case File.read(file_name(db_folder, key)) do
      {:ok, contents} -> :erlang.binary_to_term(contents)
      _ -> nil
    end
    {:reply, data, db_folder}
  end

  def handle_call({:store, key, data}, _from, db_folder) do
    file_name(db_folder, key)
    |> File.write!(:erlang.term_to_binary(data))

    {:reply, data, db_folder}
  end

  defp file_name(db_folder, key) do
    hash = key |> :erlang.phash2
    "#{db_folder}/#{hash}"
  end
end
