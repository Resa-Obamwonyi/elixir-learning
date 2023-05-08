# Using default arguments in named functions

defmodule Concat do
  def join(a, b, joiner \\ "-") do
    a <> joiner <> b
  end
end


IO.puts(Concat.join("Hello", "Worlders")) # Hello-Worlders
IO.puts(Concat.join("My", "Beauty", "#")) # My#Beauty


defmodule DefaultTest do
  def dowork(x \\ "hello") do
    x
  end
end

# note how we do not always need enclosing () brackets
DefaultTest.dowork  #=> "hello"
DefaultTest.dowork 123 #=> 123


# If a function with default values has multiple clauses,
# it is required to create a function head (a function definition without a body) for declaring defaults

defmodule NewConcat do
  # A function head declaring defaults
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do # When a variable is not used by a function or a clause, add a leading underscore (_) to its name to signal this intent
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

# note how we do not always need enclosing () brackets
IO.puts NewConcat.join("Hello", "world")      #=> Hello world
IO.puts NewConcat.join("Hello", "world", "_") #=> Hello_world
IO.puts NewConcat.join("Hello")               #=> Hello
