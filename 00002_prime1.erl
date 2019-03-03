-module(prog).
-export([main/0]).

main() ->
  {ok, [TestCaseCount]} = io:fread("", "~d"),
  process_test_cases(TestCaseCount),
  true.

process_test_cases(TestCaseCount) ->
  if
    TestCaseCount > 0 ->
      {ok, [LowerBound, UpperBound]} = io:fread("", "~d ~d"),

      print_all_primes_between(LowerBound, UpperBound),
      io:fwrite("~n"),

      process_test_cases(TestCaseCount - 1);

    true ->
      done
  end.

print_all_primes_between(LowerBound, UpperBound) ->
  case is_prime(LowerBound) of
    true ->
      io:fwrite("~B~n", [LowerBound]);

    false ->
      ok
  end,

  if
    LowerBound < UpperBound ->
      print_all_primes_between(LowerBound + 1, UpperBound);

    true ->
      done
  end.

is_prime(1) ->
  false;

is_prime(2) ->
  true;

is_prime(3) ->
  true;

is_prime(Number) when (Number rem 2 == 0); (Number rem 3 == 0) ->
  false;

is_prime(Number) ->
  UpperBound = trunc(math:sqrt(Number)),

  if
    UpperBound >= 5 ->
      not has_divisor_between(Number, 5, UpperBound);

    true ->
      true
  end.

has_divisor_between(Number, LowerBound, UpperBound) ->
  LowerBoundPlusTwo = LowerBound + 2,
  LowerBoundPlusSix = LowerBound + 6,

  if
    (Number rem LowerBound == 0) or
      ((LowerBoundPlusTwo =< UpperBound) and
        (Number rem LowerBoundPlusTwo == 0)) ->

      true;

    LowerBoundPlusSix =< UpperBound ->
      has_divisor_between(Number, LowerBoundPlusSix, UpperBound);

    true ->
      false
  end.
