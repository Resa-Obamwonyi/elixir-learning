# +, -, *, /
# div, rem
# ++, --
# string concatenation: <>
# or, and, not ---boolean operators
# ||, &&, ! ---- or, and, not

# or
# iex> 1 || true
# 1
# iex> false || 11
# 11

# and
# iex> nil && 13
# nil
# iex> true && 17
# 17

# not
# iex> !true
# false
# iex> !1
# false
# iex> !nil
# true

# NOTE: use and, or and not when you are expecting booleans. If any of the arguments are non-boolean, use &&, || and !

# Comparison operators: ==, !=, ===, !==, <=, >=, < and >
#     (perform structural comparison, i.e structures are compared based on their representation and not on their semantic value.)

# The difference between == and === is that the latter is more strict when comparing integers and floats
