defmodule LiveSentence.RoomkeyTest do
  use ExUnit.Case

  test "returns a 4-character string" do
    assert String.length(LiveSentence.Roomkey.random) == 4
  end
end
