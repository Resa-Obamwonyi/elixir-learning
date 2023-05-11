# modules (i think they are like classes)
defmodule Test do
  # do is like the : of python, also notice the tabs
  def add(a, b) do
    a + b
  end
end

# to call a function in a module
IO.puts(Test.add(3, 6))  #==> 9

# it is convenient to write modules into files so they can be compiled and reused
# files can be compiled using elixirc ---> e.g elixirc test.ex

# This will generate a file named Elixir.Math.beam containing the bytecode for the defined module.
# If we start iex again, our module definition will be available
# (provided that iex is started in the same directory the bytecode file is in)

defmodule Add do
  def sum(a, b) do
    do_sum(a, b)
  end

  defp do_sum(a, b) do # private function, cannot be accessed via module externally
    a + b
  end
end

IO.puts Add.sum(1, 2)    #=> 3
# IO.puts Add.do_sum(1, 2) #=> ** (UndefinedFunctionError) # private function error

# implementation of a function that checks if the given number is zero or not
defmodule Math do
  def zero?(0) do
    true
  end

  def zero?(x) when is_integer(x) do
    false
  end
end
# the trailing ? mark indicates that the function returns a boolean
# named functions support do: and do, just like 1f blocks

defmodule Math do
  def zero?(0), do: true
  def zero?(x) when is_integer(x), do: false
end

IO.puts Math.zero?(0)         #=> true
IO.puts Math.zero?(1)         #=> false
# IO.puts Math.zero?([1, 2, 3]) #=> ** (FunctionClauseError)
# IO.puts Math.zero?(0.0)

fun = &Math.zero?/1
# the use of &(capture operator) above allows us assign named functions to variables, same way we do for anonymous functions
fun.(0) # true

