# THE PIN OPERATOR
# Use the pin operator ^ when you want to pattern match against a variable’s existing value rather than rebinding the variable.
# We can use the pin operator inside other pattern matches, such as tuples or lists:
x = 1
[^x, 2, 3] = [1, 2, 3]  # [1, 2, 3]
{y, ^x} = {2, 1} # {2, 1}

# if you try
{y, ^x} = {2, 2} # ** (MatchError) no match of right hand side value: {2, 2}

# Because x was bound to the value of 1 when it was pinned, this last example could have been written as:
{y, 1} = {2, 2} # whic obviously isn't possible, hence the error

# If a variable is mentioned more than once in a pattern, all references should bind to the same value

# If you don’t care about a particular value in a pattern. It is a common practice to bind those values to the underscore, _
# The variable _ is special in that it can never be read from. Trying to read from it gives a compile error

[head | _ ] = [1, 2, 3]

head ==> 1
# attempting to read _ will throw a CompileError

