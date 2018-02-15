defmodule ServerTimingTest do
  use ExUnit.Case
  doctest ServerTiming

  test "greets the world" do
    assert ServerTiming.hello() == :world
  end
end
