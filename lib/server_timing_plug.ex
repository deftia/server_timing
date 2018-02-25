defmodule ServerTiming.Plug do
  @moduledoc """
  A plug to setup server_timing initial store, 
  and to set `server-timing` header.

  ## Usage

  Setup the plug in your app, is as simple as.
  ```
  defmodule Router do
    use Plug.Router
    plug ServerTiming.Plug
  end
  ```
  """
  import Plug.Conn

  @doc false
  def init(options), do: options

  @doc false
  def call(conn, _opts) do
    conn = assign(conn, :server_timing, [])

    register_before_send(conn, fn conn ->
      server_timings = conn.assigns[:server_timing]

      header_data =
        Enum.reduce(server_timings, [], fn {_, timing}, acc ->
          if timing.start_time != nil and timing.end_time != nil do
            diff = DateTime.diff(timing.end_time, timing.start_time, :millisecond)
            acc ++ ["#{timing.name}; dur=#{diff}"]
          else
            acc
          end
        end)
        |> Enum.join(", ")

      put_resp_header(conn, "server-timing", header_data)
    end)
  end
end
