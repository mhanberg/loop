defmodule LoopTest do
  use ExUnit.Case
  doctest Loop

  test "greets the world" do
    assert Loop.hello() == :world
  end
end
