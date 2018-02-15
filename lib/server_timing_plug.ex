defmodule ServerTiming.Plug do
  import Plug.Conn

  def init(_opts) do
  end

  def call(conn, _opts) do
    conn = conn
      |> Map.put("server_timings", %{})
  end
end