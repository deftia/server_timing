defstruct Timing do
  defstruct name: "Default", start: DateTime.utc_now, end: DateTime.utc_now 
end
defmodule ServerTiming do
  @moduledoc """
  Documentation for ServerTiming.
  """
  @doc """
  ## Examples

      iex> ServerTiming.hello
      :world

  """
  def start(conn, name) do
    new_server_timings = conn
    |> Map.get("server_timings")
    |> Map.put(name, %Timing{name: name})

    new_server_timings.put("server_timings", new_server_timings)
  end

  def stop(conn, name) do
    server_timing = conn
    |> Map.get("server_timings")
    |> Map.get(name)

    new_server_timing = %{ server_timing | end = DateTime.utc_now }
    conn
    |> Map.put("server_timings")
    |> Map.put(name, new_server_timing)

    conn
  end
end
