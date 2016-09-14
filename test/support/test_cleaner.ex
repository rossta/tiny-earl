defmodule TinyEarl.TestCleaner do
  def cleanup do
    {:ok, files} = File.ls("./data/test")
    Enum.each files, fn(file) -> File.rm!("./data/test/#{file}") end
  end
end
