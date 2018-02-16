defmodule ServerTiming do
  defstruct name: "default", start_time: nil, end_time: nil

  @moduledoc """
  Documentation for ServerTiming.
  """
  @doc """
    Registers start time for a specified `"name"`
  """
  @spec start(Plug.Conn, String.t()) :: Plug.Conn
  def start(conn, name) when is_bitstring(name) do
    start_time(conn, String.to_atom(name))
  end

  @spec start(Plug.Conn, Atom.t()) :: Plug.Conn
  def start(conn, name) when is_atom(name) do
    start_time(conn, name)
  end

  @doc """
    Registers stop time for a specified `"name"`
  """
  @spec stop(Plug.Conn, String.t()) :: Plug.Conn
  def stop(conn, name) when is_bitstring(name) do
    stop_time(conn, String.to_atom(name))
  end

  @spec stop(Plug.Conn, Atom.t()) :: Plug.Conn
  def stop(conn, name) when is_atom(name) do
    stop_time(conn, name)
  end

  defp start_time(conn, name) do
    Plug.Conn.assign(
      conn,
      :server_timing,
      conn.assigns[:server_timing]
      |> put_in([name], %ServerTiming{name: name, start_time: DateTime.utc_now()})
    )
  end

  defp stop_time(conn, name) do
    Plug.Conn.assign(
      conn,
      :server_timing,
      conn.assigns[:server_timing] |> update_in([name], &%{&1 | end_time: DateTime.utc_now()})
    )
  end
end
