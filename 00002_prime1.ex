defmodule PrimeGenerator do
  def process_test_cases(test_case_count) do
    if test_case_count > 0 do
      {:ok, [lower_bound, upper_bound]} = :io.fread('', '~d ~d')

      print_all_primes_between(lower_bound, upper_bound)
      IO.puts("")

      process_test_cases(test_case_count - 1)
    else
      :done
    end
  end

  defp print_all_primes_between(lower_bound, upper_bound) do
    if lower_bound |> is_prime?() do
      IO.puts(lower_bound)
    end

    if lower_bound < upper_bound do
      print_all_primes_between(lower_bound + 1, upper_bound)
    else
      :done
    end
  end

  defp is_prime?(1), do: false
  defp is_prime?(2), do: true
  defp is_prime?(3), do: true

  defp is_prime?(number)
       when number |> rem(2) == 0 or number |> rem(3) == 0 do
    false
  end

  defp is_prime?(number) do
    upper_bound = number |> :math.sqrt() |> trunc()

    if upper_bound >= 5 do
      not (number |> has_divisor_between?(5, upper_bound))
    else
      true
    end
  end

  defp has_divisor_between?(number, lower_bound, upper_bound) do
    lower_bound_plus_two = lower_bound + 2
    lower_bound_plus_six = lower_bound + 6

    cond do
      number |> rem(lower_bound) == 0 or
          (lower_bound_plus_two <= upper_bound and
             number |> rem(lower_bound_plus_two) == 0) ->
        true

      lower_bound_plus_six <= upper_bound ->
        number |> has_divisor_between?(lower_bound_plus_six, upper_bound)

      true ->
        false
    end
  end
end

{:ok, [test_case_count]} = :io.fread('', '~d')
PrimeGenerator.process_test_cases(test_case_count)
