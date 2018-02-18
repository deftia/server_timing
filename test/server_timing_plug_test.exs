defmodule ServerTimingPlugTest do
  use ExUnit.Case
  use Plug.Test

  setup do
    conn = ServerTiming.Plug.call(conn(:get, "/", ""), ServerTiming.Plug.init([]))
    {:ok, [conn: conn]}
  end

  test "set start time on conn", context do
    conn = ServerTiming.start(context[:conn], :test)
    assert Keyword.has_key?(conn.assigns[:server_timing], :test) == true
    assert conn.assigns[:server_timing][:test] != nil
    assert conn.assigns[:server_timing][:test].start_time != nil
    assert conn.assigns[:server_timing][:test].end_time == nil
  end

  test "stop time must update end_time", context do
    conn = ServerTiming.start(context[:conn], :test)
    conn = ServerTiming.stop(conn, :test)
    assert Keyword.has_key?(conn.assigns[:server_timing], :test) == true
    assert conn.assigns[:server_timing][:test] != nil
    assert conn.assigns[:server_timing][:test].start_time != nil
    assert conn.assigns[:server_timing][:test].end_time != nil
  end

  test "set server-timing header with each timing info", context do
    conn = ServerTiming.start(context[:conn], :test)
    conn = ServerTiming.stop(conn, :test)
    resp_conn = send_resp(conn, 200, "")
    sent_conn = sent_resp(resp_conn)
    headers = elem(sent_conn, 1)
    assert Enum.empty?(headers) == false
    server_timings = Enum.find(headers, fn(x) -> elem(x, 0) == "server-timing" end) 
    assert server_timings != nil
  end
end
