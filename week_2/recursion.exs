# Data structures in Elixir are immutable. For this reason, functional languages rely on recursion: a function is called recursively
# until a condition is reached that stops the recursive action from continuing

defmodule Recursion do
  def print_multiple_times(msg, n) when n > 0 do
    IO.puts(msg)
    print_multiple_times(msg, n - 1)
  end

  def print_multiple_times(_msg, 0) do
    :ok
  end

end

IO.inspect(Recursion.print_multiple_times("Hello!", 3))

# Hello!
# Hello!
# Hello!
# :ok

# if you pass an argument that does not match any clause, Elixir raises a FunctionClauseError
# Recursion to Sum numbers

defmodule MathReduce do
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    accumulator
  end
end

IO.puts(MathReduce.sum_list([1, 2, 3], 0)) #=> 6


# REDUCE:
# The process of taking a list and reducing it down to one value is known as a reduce algorithm and is central to functional programming

# What if we instead want to double all of the values in our list?

defmodule MathDouble do
  def double_each([head | tail]) do
    [head * 2 | double_each(tail)]
  end

  def double_each([]) do
    []
  end
end
IO.puts(MathDouble.double_each([1, 2, 3])) #=> [2, 4, 6]

# Here we have used recursion to traverse a list, doubling each element and returning a new list.

# MAP:
# The process of taking a list and mapping over it is known as a map algorithm.
