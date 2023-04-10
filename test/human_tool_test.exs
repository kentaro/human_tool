defmodule HumanToolTest do
  use ExUnit.Case
  doctest HumanTool

  test "greets the world" do
    assert HumanTool.hello() == :world
  end
end
