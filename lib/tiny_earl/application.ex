defmodule TinyEarl.Application do
  use Application

  def start(_, _) do
    TinyEarl.Supervisor.start_link
  end
end
