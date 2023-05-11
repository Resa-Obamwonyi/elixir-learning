# The Enum module is for working with Enumerables e.g
# Lists, Maps
# The Enum module provides a huge range of functions to transform, sort, group, filter and retrieve items from enumerables
# Results are generated once.

# [2, 4, 6]
Enum.map([1, 2, 3], fn x -> x * 2 end)

# [2, 12]
Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end)

# true
Enum.all?([2,4,6,8], fn x -> rem(x, 2) == 0 end)

# true, just a different way of writing it
Enum.all?([2,4,6,8], &(rem(&1, 2) == 0) )


# the above checks if all values in the enumerable evaluates to true using the fn function, in this case, checks all even numbers

# All the functions in the Enum module are Eager (what does this mean?)
#

# STREAMS --> not exactly sure what eager versus lazy means, i think this means it generates results one at a time
# An alternative to enums that supports lzay operations
# Any enumerable that generates elements one by one during enumeration is called a stream e.g Range
#
# 7500000000
1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum()

# Instead of generating intermediate lists, streams build a series of computations that are invoked only when we pass the underlying
# stream to the Enum module. Streams are useful when working with large, possibly infinite, collections.
# streams can be very useful for handling large files or even slow resources like network resources

range = 1..3
stream = Stream.map(range, &(&1 * 2))
Enum.map(stream, &(&1 + 1))
[3, 5, 7]

# Note that we started with a range and then we created a stream that is meant to multiply each element in the range by 2.
# At this point, no computation was done. Only when Enum.map/2 is called we actually enumerate over each element in the range,
# multiplying it by 2 and adding 1. We say the functions in Stream are lazy and the functions in Enum are eager.
