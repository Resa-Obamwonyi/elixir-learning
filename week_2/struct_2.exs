defmodule User do
  defstruct :first_name, :last_name, :birthday

  # __MODULE__ referes to the current module name
  def full_name(%__MODULE__{} = user_input) do
    "#{user_input.first_name} #{user_input.last_name}"
  end

  # similar to above, but it doesnt require the struct - could be any map with the two keys
  # but in this case the above function head is prefered
  def full_name(%{first_name: first_name, last_name: last_name}) do
    "#{first_name} #{last_name}"
  end

  # explicit usage of the module name
  def age(%User{} = user_input) do
    # .. calculate age based on current date and `user.birthday`
  end

  # underneath the mattern matching is the following...
  def age(%{__struct__: :Elixir.User} = user_input) do
    # .. calculate age based on current date and `user.birthday`
  end
end


john = %User{first_name: "John", last_name: "Doe", birthday: ~D"1988-10-10}
# equal to. The above syntax will be converted to
%{__struct__: :Elixir.User, first_name: "John", last_name: "Doe", birthday: ~D"1988-10-10}

%{__struct__: User, first_name: "John", last_name: "Doe", birthday: ~D"1988-10-10}

User.full_name(john)
User.age(john)

# breaks because it's not a user struct
User.age(%{birthday: ~D"1988-10-10})

# not working
# john.full_name()




## require
defmodule ModuleA do
  def test do
    "test"
  end
end

defmodule ModuleB do
  import ModuleA

  def mytest do
    test()
  end
end

# equal to
defmodule ModuleB do
  def mytest do
    ModuleA.test()
  end
end

ModuleB.test()
