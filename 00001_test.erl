-module(prog).
-export([main/0]).

main() ->
  search_for_the_answer().

search_for_the_answer() ->
  case io:fread("", "~d") of
    {ok, [42]} ->
      found;

    {ok, [Number]} ->
      io:fwrite("~B~n", [Number]),
      search_for_the_answer();

    eof ->
      not_found
  end.
