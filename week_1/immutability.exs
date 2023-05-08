# The concept of data immutability is that once data is created in a memory location, it cannot be altered.
# Immutability must be preserved.

The Match Operator =
  In Elixir, the = is not an assignment operator and if you see any instructions or statements similar to a=7 is not an assignment.
  Here, a=7 means a match or binding. So, = in Elixir is a matching operator

  # data for a variable is not changed, instead the variable is pointed to another point/address in memory
  # data immutability means that the state of data can’t be altered after it’s created at a certain memory location

  # what is the difference between match/binding and assignment?
  marks = 300
  print_marks = fn -> IO.puts marks end

  print_marks.() # prints 300
  # pointer to new address
  marks = 500
  print_marks.() # prints 300

  When marks = 300 it is pointing to some x address and when marks = 500 it is pointing to some other y address.

  # As we defined our print_marks function when marks = 300 pointing to some x address,
  # it always prints 300 though marks = 500 has been set since it is pointing to some other address location as our function
  # only cares about the the address it is pointing before
