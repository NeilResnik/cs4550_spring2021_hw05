defmodule Bulls.Game do

  # Generates a new game state with a random secret
  def new do
    %{
      secret: random_secret(),
      guesses: [],
      results: []
    }
  end

  # Returns true if the game state shows the game is not over, false otherwise
  def canGuess(%{results: [last_result | _]} = st) do
    last_result != "4A0B" and length(st.guesses) < 8
  end

  def canGuess(_) do
    true
  end

  # Returns a state with the results of the given guess given. If the game is
  # over the same state is returned
  def guess(st, gg) do
    if canGuess(st) do
      result = List.foldl(gg,
                          %{posn: 0, a_cnt: 0, b_cnt: 0},
                          fn el, acc ->
                            cond do
                              el == elem(List.pop_at(st.secret, acc.posn), 0) ->
                                %{posn: acc.posn + 1,
                                  a_cnt: acc.a_cnt + 1,
                                  b_cnt: acc.b_cnt}
                              el in st.secret ->
                                %{posn: acc.posn + 1,
                                  a_cnt: acc.a_cnt,
                                  b_cnt: acc.b_cnt + 1}
                              true -> %{acc | posn: acc.posn + 1}
                            end
                          end)

      %{
        secret: st.secret,
        guesses: [List.to_string(gg) | st.guesses],
        results: ["#{result.a_cnt}A#{result.b_cnt}B" | st.results]
      }
    else
      st
    end
  end

  # Returns a view of the game state without the secret for the user
  def view(st) do
    %{
      guesses: st.guesses,
      results: st.results
    }
  end

  # Private functions to generate a 4 digit list of unique integers for the secret
  defp random_secret_helper(acc, 4) do
    acc
  end

  defp random_secret_helper(acc, size) do
    base_charset = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -- acc
    random_secret_helper([Enum.random(base_charset) | acc], size + 1)
  end


  defp random_secret do
    random_secret_helper([], 0)
  end

end
