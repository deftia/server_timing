defmodule ServerTimingTest do
  use ExUnit.Case
  use Plug.Test

  setup do
    conn = ServerTiming.Plug.call(conn(:get, "/", ""), ServerTiming.Plug.init([]))
    {:ok, [conn: conn]}
  end

  test "set start time on conn", context do
    conn = ServerTiming.start(context[:conn], :test)
    assert Map.has_key?(conn.assigns[:server_timing], :test) == true
    assert conn.assigns[:server_timing][:test] != nil
    assert conn.assigns[:server_timing][:test].start_time != nil
    assert conn.assigns[:server_timing][:test].end_time == nil
  end

  test "stop time must update end_time", context do
    conn = ServerTiming.start(context[:conn], :test)
    conn = ServerTiming.stop(conn, :test)
    assert Map.has_key?(conn.assigns[:server_timing], :test) == true
    assert conn.assigns[:server_timing][:test] != nil
    assert conn.assigns[:server_timing][:test].start_time != nil
    assert conn.assigns[:server_timing][:test].end_time != nil
  end
end
