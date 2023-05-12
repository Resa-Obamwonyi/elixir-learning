# Structs are extensions built on top of maps that provide compile-time checks and default values
# To define a struct, the defstruct construct is used



defmodule User do
  # The keyword list used with defstruct defines what fields the struct will have along with their default values
  defstruct name: "John", age: 27
end



# Structs take the name of the module they are defined in, in the above example we have defined a struct named "User"
# Structs are bare maps underneath, none of the protocols for maps are available for structs, but syntax wise, they are similar
# You cannot enumerate or access a structure
# However, since structs are just maps, they work with the functions from the Map module:

jane = Map.put(%User{}, :name, "Jane") # %User{age: 27, name: "Jane"}
Map.merge(jane, %User{name: "John"}) # %User{age: 27, name: "John"}
Map.keys(jane) #[:__struct__, :age, :name]



# We can now create User structs by using a syntax similar to the one used to create maps:
# user struct without values uses the default values
%User{}  # ===> %User{age: 27, name: "John"}

# You can set just one value and the other takes the default
%User{name: "Jane"}   # ===> %User{age: 27, name: "Jane"}

# Structs provide compile-time guarantees that only the fields defined through defstruct will be allowed to exist in a struct
%User{oops: :field} # ==> ** (KeyError) key :oops not found expanding struct: User.__struct__/1

# Accessing and Updating STRUCTS
john = %User{} # %User{age: 27, name: "John"}
john.name   # "John"

# Update the value of "name" with "Jane" and save to a new variable ==> %User{age: 27, name: "Jane"}
jane = %{john | name: "Jane"}

%{jane | oops: :field}  # ==>  ** (KeyError) key :oops not found in: %User{age: 27, name: "Jane"}


# pattern matching works because underneath structs are bare maps with a fixed set of fields.
is_map(john)  # ==> true

# As maps, structs store a “special” field named __struct__ that holds the name of the struct
john.__struct__ # ==> User


# Differences between Maps and Structs
- Maps are key and value pairs, while structs are defined functions that may use keyword lists for default values
- A map is initialized with the syntax %{} while a struct is initialized %ModuleName{}
- Keys in structs must be atoms, Keys in maps can be anything
- Unlike Structs, Maps do not provide compile time checks and default values


# Notes
- If you do not specify a default key value when defining a struct, nil will be assumed:
- You can define a structure combining both fields with explicit default values, and implicit nil values.
- In this case you must first specify the fields which implicitly default to nil
- You can also enforce that certain keys have to be specified when creating the struct via the @enforce_keys module attribute

defmodule Car do
    @enforce_keys [:make]
    defstruct [:model, :make]
end

# If you try to create Car without make, an argument error is thrown
%Car{} # ** (ArgumentError) the following keys must also be given when building struct Car: [:make] expanding struct: Car.__struct__/1

- Enforcing keys provides a simple compile-time guarantee to aid developers when building structs.
- It is not enforced on updates and it does not provide any sort of value-validation.
- It is safe to use Structs when:
    - We know all the keys ahead of time
    - We want to achieve data polymorphism (Invoking a function depending on the struct type.)


# Working with Structs and Functions that share the same module
