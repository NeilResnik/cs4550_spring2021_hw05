defmodule Bulls.Game do

  def new do
    %{
      secret: random_secret(),
      guesses: [],
      results: []
    }
  end

  defp guess_helper(secret, [], posn, a_cnt, b_cnt) do
  end

  defp guess_helper(secret, gg_list, posn, a_cnt, b_cnt) do
  end

  def guess(st, gg) do
    result = guess_helper(st.secret, gg.grapheme(), 0, 0, 0)
    %{
      secret: st.secret,
      guesses: st.guesses ++ [gg],
      results: st.guesses ++ [result]
    }
  end

  def view(st) do
    %{
      guesses: st.guesses,
      results: st.results
    }
  end

  defp random_secret_helper(acc, 4) do
    acc
  end

  defp random_secret_helper(acc, size) do
    base_charset = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] -- acc
    random_secret_helper([Enum.random(base_charset) | acc], size + 1)
  end


  defp random_secret do
    random_secret_helper([], 0)
  end

end
