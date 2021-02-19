defmodule Bulls.BullsTest do
  use ExUnit.Case
  import Bulls


  test "guess checks" do
    state = Bulls.Game.new
    # force secret to be something constant
    state = %{state | secret:  ["1", "2", "3", "4"]}

    assert Bulls.Game.canGuess state
    state = Bulls.Game.guess(state, ["3", "4", "5", "6"])
    assert state.guesses == ["3456"]
    assert state.results == ["0A2B"]

    assert Bulls.Game.canGuess state
    state = Bulls.Game.guess(state, ["1", "2", "5", "4"])
    assert state.guesses == ["1254", "3456"]
    assert state.results == ["3A0B", "0A2B"]

    assert Bulls.Game.canGuess state
    state = Bulls.Game.guess(state, ["1", "2", "3", "4"])
    assert state.guesses == ["1234", "1254", "3456"]
    assert state.results == ["4A0B", "3A0B", "0A2B"]
    assert !Bulls.Game.canGuess state

    state = %{
      secret: ["1", "2", "3", "4"],
      guesses: ["5678", "6789", "7890", "0789", "0987", "6789", "6789", "9087"],
      results: ["0A0B", "0A0B", "0A0B", "0A0B", "0A0B", "0A0B", "0A0B", "0A0B"]
    }
    assert !Bulls.Game.canGuess state
  end
end
