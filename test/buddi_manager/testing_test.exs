defmodule TestingTest do
  use ExUnit.Case
  doctest Testing
  alias Testing

  test "return correct output" do
    assert Testing.replace("aabbcc", ["ab"]) == "bbaacc"
    assert Testing.replace("adam", ["ab", "cd"]) == "bcbm"
  end

  test "return proper offset to shift" do
    chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    assert Testing.get_shifted_character(chars, "f", 1) == "g"
    assert Testing.get_shifted_character(chars, "Z", 1) == "a"
    assert Testing.get_shifted_character(chars, "z", 2) == "B"
    assert Testing.get_shifted_character(chars, "z", 14) == "N"
    assert Testing.get_shifted_character(chars, "f", 50) == "d"
  end
end
