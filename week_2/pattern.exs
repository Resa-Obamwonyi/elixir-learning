# The Match Operator '='
# a variable can only be assigned on the left side of =
# This is a way of stating that the left-hand side is equivalent to the right-hand side
# Pattern matching allows developers to easily destructure data types such as maps, tuples and lists
# This is seems to be a way of binding multiple variables to values

{a, b, c} = {:hello, "world", 42}
a ==> :hello
b ==> "world"
c ==> 42

# a pattern match error will occur if the sides cannot be matched, i.e if the tuples have different sizes
{a, b, c} = {:hello, "world"}  # ** (MatchError) no match of right hand side value: {:hello, "world"}

# a pattern match error will also occur when trying to match different types, e.g a tuple to a list
{a, b, c} = [:hello, "world", 42] # ** (MatchError) no match of right hand side value: [:hello, "world", 42]

# Pattern Matching Lists
# Pattern matching in lists is a way to destructure and extract certain values into variables
# but this will work, pattern matching works for lists in tow ways, 1: match entire lists
[a, b, c] = [:hello, "world", 42]

# 2: you can also pattern match list head and tail
[head | tail] = [1, 2, 3]

IO.puts(head) # 1
IO.puts(tail) # [2, 3]

# Pattern Matching Tuples
# We can match with specific values
# The example below asserts that the left side will only match the right side when the right side is a tuple that starts with the atom :ok
{:ok, result} = {:ok, 13}  # ==> {:ok, 13}
IO.puts(result) # ==> 13

{name, age, interests} = {"Krishna", 22, ["Elixir", "Elm"]}
# name = "Krishna", age = 22, interests = ["Elixir", "Elm"]

# ERROR
{:ok, result} = {:error, :oops} # ** (MatchError) no match of right hand side value: {:error, :oops}


# Pattern Matching Maps
# Pattern matching also provides us with an easy way to extract values from a map and assign to a variable

%{name: name} = %{name: "Krishna", city: "Toronto"}
# name ===> "Krishna"

%{city: name_of_city} = %{name: "Krishna", city: "Toronto"}
# name_of_city ===> "Toronto"


# Pattern Matching with Functions
# In Elixir it is possible to pattern match function arguments

def save({:ok, valid_data}) do # pattern matching arguments if successful
  # Proceed to save the data
end

def save({:error, error}) do # pattern matching arguments for errors
  # Skip and log the error
end
# note that the first function clause to match the pattern will be executed
# In the example below, the second function clause will never be executed (because the first clause will always match)
# Question: Explain more on function pattern matching
def process_data(data) do
  # process the data
  {:ok, processed_data}
end

def process_data([]) do
  {:error, "No data provided"} # This will never be executed!
end

# Do not understand this example
key = "name"
parameters = %{"name" => "Krishna"}
case parameters do
 %{^key => name} -> save(name)
 _ -> IO.inspect "Name not present in the parameter"
end


# USE CASES
# - Validate data returned from an external API to ensure that it contains all the fields the domain cares about, In case of invalid data, a MatchError will be thrown, and can be handled by the caller
# - Error handling: It is common for Elixir functions to return a tuple to indicate whether an operation succeeded or not, \
    # Pattern Matching provides a clean way to handle errors as most of the core functions in Elixir and corresponding hex packages return a tuple to indicate whether it was successful or not.
