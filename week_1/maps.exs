# associative data structures - hashes, dictionaries, objects

# KEYWORD LISTS
# Keyword lists are a data-structure used to pass options to functions
# e.g String.split("1 2 3", " ") ====> ["1", "2", "3"]

String.split("1  2  3", " ", [trim: true])
[trim: true] # is a key word list

list = [a:1, b:2]
list ++ [c:3] =====> [a:1, b:2, c:3]

# when a keyword list is the last argument of a function, we can skip the brackets
String.split("1  2  3", " ", trim: true)

# you can read the value of a keyword list using the bracket syntax
list[:a] ==> 1

# prepend to front of a list
list = [1, "2", :mass]
new_list = ["new" | list]   # ["new", 1, "2", :mass]

# MAPS
# maps are elixir's key-value store, syntax %{}
map = %{:a => 1, 2 => :b}
map[:a] ---> 1
map[2] ---> b
map[c] --> nil

# to update a key value, this syntax can only update not add new keys
map = %{:a => 1, 2 => :b}
%{map | 2 => "two"} # set map object key 2 to string that says two

# When all the keys in a map are atoms, a shortcut syntax is allowed, no need to arrow assignment
map = %{a: 1, b: 2}
# you can use dot notation to access atom keys
# e.g
map.a ===> 1
map.b ===> 2

# maps have get_and_update, update_in, get_and_update_in, put_new

# DO KEYWORD

if true, do: "This will be seen", else: "This won't" ==> "This will be seen"
# or, another syntax approach
if true do
    "This will be seen"
else
    "This won't"
end

# block ketywords: do, else, catch, rescue, after

# NESTED DATA STRUCTURES
users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]
# to get value
users[:john].age # 27

# to change a value
users = put_in users[:john].age, 31 #[ john: %{age: 31, languages: ["Erlang", "Ruby", "Elixir"], name: "John"}, mary: %{age: 29, languages: ["Elixir", "F#", "Clojure"], name: "Mary"}]

# to remove a single value in an array of values, or modify in a certain way
users = update_in users[:mary].languages, fn languages -> List.delete(languages, "Clojure") end
# [ john: %{age: 31, languages: ["Erlang", "Ruby", "Elixir"], name: "John"}, mary: %{age: 29, languages: ["Elixir", "F#"], name: "Mary"}]

# get_and_update_in/2 that allows us to extract a value and update the data structure at once.
# There are also put_in/3, update_in/3 and get_and_update_in/3 which allow dynamic access into the data structure

# ENUMS
# Functions for working with collections such as Lists, Maps, Range
# Enum.sum([1, 2, 3]) ===> 6 can also be written as Enum.sum(1..3)
# Enum.map([1, 2, 3], fn x -> x * 2 end) ===> [2, 4, 6]

map = %{"a" => 1, "b" => 2}
Enum.map(map, fn {k, v} -> {k, v * 2} end)  ====> [{"a", 2}, {"b", 4}] # k,v represents key and value

# Enum at function
Enum.at([2, 4, 6], 0) ==> 2

Enum.at([2, 4, 6], 2) ==> 6

Enum.at([2, 4, 6], 4) ==> nil

Enum.at([2, 4, 6], 4, :none)  ==> :none # none is passed as a default value
