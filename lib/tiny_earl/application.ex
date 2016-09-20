defmodule TinyEarl.Application do
  use Application

  def start(_, _) do
    response = TinyEarl.Supervisor.start_link
    TinyEarl.Web.start_server

    response
  end
end
