defmodule TinyEarl.Web do
  use Plug.Router

  plug :match
  plug :dispatch

  def start_server do
    Plug.Adapters.Cowboy.http(__MODULE__, nil, port: 5454)
  end

  post "/add_url" do
    if conn.params["url"] do
      conn
      |> Plug.Conn.put_resp_content_type("text/plain")
      |> Plug.Conn.fetch_query_params
      |> add_url
      |> respond
    else
      conn
      |> Plug.Conn.send_resp(422, "Missing url parameter")
    end
  end

  defp add_url(conn) do
    conn.params
    |> Map.get("domain", "http://localhost:5454")
    |> TinyEarl.Cache.server_process
    |> TinyEarl.Server.add_url(conn.params["url"])
    Plug.Conn.assign(conn, :response, "OK")
  end

  def parse_date(
    << year::binary-size(4), month::binary-size(2), day::binary-size(2) >>
  ) do
    {String.to_integer(year), String.to_integer(month), String.to_integer(day)}
  end

  def respond(conn) do
    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, conn.assigns[:response])
  end
end
