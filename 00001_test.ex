defmodule AnswerSeeker do
  def search_for_the_answer() do
    case :io.fread('', '~d') do
      {:ok, [42]} ->
        :found

      {:ok, [number]} ->
        IO.puts(number)
        search_for_the_answer()

      :eof ->
        :not_found
    end
  end
end

AnswerSeeker.search_for_the_answer()
