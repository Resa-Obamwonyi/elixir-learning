# BASIC TYPES
IO.puts(rem 250, 22)
IO.puts(div 200, 4)
IO.puts(div(22, 11))
# binary numbers - 0b1010
# octal numbers - 0o777
# hexadecimal numbers - 0x1F

# floats can also be written as raised to powers
IO.puts(1.0e-10)

# invoke the round function to get the closest integer
IO.puts(round(6.575)) # 7

# use the trunc function to get the integer part of a float.
IO.puts(trunc(6.575)) # 6

# An atom is a constant whose value is its own name. Some other languages call these symbols
# use is_boolean(), is_integer(), is_float() or is_number() to check data types, results are either true or false
# user is_binary("hellö") to check for strings

IO.puts(string = :world)
IO.puts("hellö #{string}")  # prints ==> "hellö world"

IO.puts(string = "my darling new world")
IO.puts("hellö #{string}")  # prints ==> "hellö my darling new world"

# "hello...> world" or "hello\nworld" for multi-line strings
# Strings in Elixir are represented internally by contiguous sequences of bytes known as binaries
# We can also get the number of bytes in a string: byte_size("hellö")

# get length of string
IO.puts(String.length("Mailman")) #7

# Make string Upper case
IO.puts(String.upcase("mailman")) # MAILMAN

# Anonymous functions
add = fn a, b -> a + b end
IO.puts(add.(7, 3)) # 10
IO.puts(is_function(add)) #true

# (Linked) Lists
my_list = [1, 2, true, 3]
IO.puts(length(my_list)) #prints 4

# to concatenate lists ++ e.g [1, 2, 3] ++ [4, 5, 6]
# to subtract lists [1, true, 2, false, 3, true] -- [true, false, true] = [1, 2, 3]

# get head of list
IO.puts(hd(my_list)) #1

# get tail of list
# IO.puts(tl(my_list)) #[2, true, 3]

# NOTE: When Elixir sees a list of printable ASCII numbers, Elixir will print that as a charlist (literally a list of characters)
# e.g [104, 101, 108, 108, 111] ==> 'hello'

# NOTE: Keep in mind single-quoted and double-quoted representations are not equivalent in Elixir as they are represented by different types
# Single quotes are charlists, double quotes are strings

# Tuples - not like lists, encloses with {} and can be accessed by index
tup = {:ok, "hello"}
my_tup_size = tuple_size(tup)

IO.puts(tup)
IO.puts(elem(tup, 1))

# replace an element in a specific position
put_elem(tup, 1, "fish") # returns new tuple {:ok, "fish"}
# NOTE: this does not modify the previous tuple, but stores the result in a new tuple
# just like lists, tuples are immutable

# Differences btwn lists and tuples
# storage:
  # LISTS
    # Lists are stored in memory as linked lists, meaning that each element in a list holds its value and points to the following element
    # until the end of the list is reached. This means accessing the length of a list is a linear operation:
    # we need to traverse the whole list in order to figure out its size.
  # TUPLES
    # Tuples, on the other hand, are stored contiguously in memory.
    # This means getting the tuple size or accessing an element by index is fast
    # However, updating or adding elements to tuples is expensive because it requires creating a new tuple in memory:

# TIP: the function is named size if the operation is in constant time
# (i.e. the value is pre-calculated) or length if the operation is linear (i.e. calculating the length gets slower as the input grows)

# COUNTERS
# byte_size/1 (for the number of bytes in a string),
# tuple_size/1 (for tuple size),
# length/1 (for list length)
# String.length/1 (for the number of graphemes in a string).
