# When pattern matching on strings, it is important to use the utf8 modifier:
# double-quotes must always be used to represent strings in Elixir
# You can convert a charlist to a string and back by using the to_string/1 and to_charlist/1 functions
# also for atoms

to_string(:male) ==> "male"

# Question: How do we navigate the following
  # Interpreting integers as code points may lead to some surprising behavior.
  # For example, if you are storing a list of integers that happen to range between 0 and 127,
  # by default IEx will interpret this as a charlist and it will display the corresponding ASCII characters.
# e.g
heartbeats_per_minute = [99, 97, 116] ===> 'cat'

# String (binary) concatenation uses the <> operator but charlists, being lists, use the list concatenation operator ++
