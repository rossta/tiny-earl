defmodule TinyEarl.Link do
  alias TinyEarl.Serializer
  defstruct url: nil, token: nil, uuid: nil

  def shorten(url) do
    uuid = UUID.uuid5(:url, url, :hex)
    |> :erlang.phash2

    %{uuid: uuid, url: url, token: Serializer.encode(uuid)}
  end
end
