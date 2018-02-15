defmodule ServerTiming.Plug do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    assign(conn, :server_timing, %{})
  end
end
