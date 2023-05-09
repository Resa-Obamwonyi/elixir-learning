# CASE
# case allows us to compare a value against many patterns until we find a matching one:
case 1 / 6 do
  0.5 -> 0.5
  # prints this
  _other -> "no result"
end

case {1, 2, 3} do
  {4, 5, 6} ->
    "This clause won't match"

  {1, x, 3} ->
    # prints this
    "This clause will match and bind x to 2 in this clause"

  _other ->
    "This clause would match any value"
end

myball = "Hockey"

case myball do
  "football" ->
    "I love football"

  _anysport ->
    # this is printed
    "I tolerate other sports"
end

# COND
# In many circumstances, we want to check different conditions and find the first one that does not evaluate to nil or false
# This is equivalent to else if clauses in many imperative languages - although used less frequently in Elixir.

cond do
  2 + 2 == 5 ->
    "This will not be true"

  2 * 2 == 3 ->
    "Nor this"

  1 + 1 == 2 ->
    # prints this as it is the first to evaluate to true or not nil
    "But this will"
end

# If all of the conditions return nil or false, an error (CondClauseError) is raised.
# For this reason, it may be necessary to add a final condition, equal to true, which will always match:
# note that cond considers any value besides nil and false to be true

cond do
  2 + 2 == 5 ->
    "This is never true"

  2 * 2 == 3 ->
    "Nor this"

  true ->
    # final condition, always true
    "This is always true (equivalent to else)"
end

# IF and UNLESS
# if/2 and unless/2 -> meaning they each accept 2 arguments
# These are useful when you need to check for only one condition

if true do
  "This works!" # prints this
end

unless true do
  "This will never be seen" # prints nil
end

# If the condition given to if/2 returns false or nil, the body given between do-end is not executed and instead it returns nil.
# The opposite happens with unless/2
# They also support else blocks

# note: If any variable is declared or changed inside if, case, and similar constructs,
      # the declaration and change will only be visible inside the construct

# GUARDS
# Guards give the ability to perform complex checks

# comparison operators (==, !=, ===, !==, <, <=, >, >=)
# strictly boolean operators (and, or, not).
# arithmetic unary operators (+, -)
# arithmetic binary operators +, -, *, /)
# in and not in operators (as long as the right-hand side is a list or a range)
# "type-check" functions (is_list/1, is_number/1, and the like)
# functions that work on built-in datatypes (abs/1, hd/1, map_size/1, and others)
# the map.field syntax

def empty_map?(map) when map_size(map) == 0, do: true
def empty_map?(map) when is_map(map), do: false

# Guards start with the when operator, followed by a guard expression.
# The clause will be executed if and only if the guard expression returns true


# WITH
# This is used to combine matching clauses

