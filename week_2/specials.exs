# __MODULE__
- This returns the current module name as an atom, or nil if otherwise

# alias
- alias(module, opts), this is used to setup aliases for module names
- Note that calling alias without the :as option automatically sets an alias based on the last part of the module. For example:

alias Foo.Bar.Baz is same as alias Foo.Bar.Baz, as: Baz

- import/2, require/2 and alias/2 are called directives and all have lexical scope. This means you can set up aliases inside specific functions and it will not affect the overall scope


# require
- it is used to require a module in order to use its macros
- what are macros?

# try block
- This is used to evaluate an expression or block and handle any exception thrown

try do
  do_something_that_may_fail(some_arg)
rescue
  ArgumentError ->
    IO.puts("Invalid argument given")
catch
  value ->
    IO.puts("Caught #{inspect(value)}")
else
  value ->
    IO.puts("Success! The result was #{inspect(value)}")
after
  IO.puts("This is printed regardless if it failed or succeeded") # like a finally
end


# The rescue clause is used to handle exceptions while the catch clause can be used to catch thrown values and exits.
# The else clause can be used to control flow based on the result of the expression. catch, rescue,
# and else clauses work based on pattern matching (similar to the case special form)

# Rescue a single exception without binding the exception
# to a variable
try do
  UndefinedModule.undefined_function
rescue
  UndefinedFunctionError -> nil
end

# Rescue any of the given exception without binding
try do
  UndefinedModule.undefined_function
rescue
  [UndefinedFunctionError, ArgumentError] -> nil
end

# Rescue and bind the exception to the variable "x"
try do
  UndefinedModule.undefined_function
rescue
  x in [UndefinedFunctionError] -> nil
end

# Rescue all kinds of exceptions and bind the rescued exception
# to the variable "x"
try do
  UndefinedModule.undefined_function
rescue
  x -> nil
end


# import
allows one to easily access functions or macros from other modules without using the qualified name
import List
flatten([1, [2], 3]) # you receive access to the flatten function within the List module
[1, 2, 3]

# You can specify only a group to import:
import List, only: :functions
import List, only: :macros
import Kernel, only: :sigils

# Alternatively
import List, only: [flatten: 1] # the number is for the number of arguments accepted
import String, except: [split: 2]

- By default functions starting with _ are not imported.
- If you really want to import a function starting with _ you must explicitly include it in the :only selector

import File.Stream, only: [__build__: 3]

# NOTE
# If you import a module and you don't use any of the imported functions or macros from this module,
# Elixir is going to issue a warning implying the import is not being used.

# In case the import is generated automatically by a macro, Elixir won't emit any warnings though,
# since the import was not explicitly defined.

# SUMMARY
# Alias the module so it can be called as Bar instead of Foo.Bar
alias Foo.Bar, as: Bar

# Require the module in order to use its macros
require Foo

# Import functions from Foo so they can be called without the `Foo.` prefix
import Foo

# Invokes the custom code defined in Foo as an extension point
use Foo
