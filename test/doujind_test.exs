defmodule DoujindTest do
  use ExUnit.Case
  doctest Doujind

  test "greets the world" do
    assert Doujind.hello() == :world
  end
end
