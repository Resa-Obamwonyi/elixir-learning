# Phoneix is a web development framework, written in Elixir, which implements server side MVC pattern
# Hex is the package manager needed to get a phoenix app running
# mix help phx.new --> to get help on phoenix

# Phoenix configures apps to use postgres dbs by default,
# but we can switch to MySQL, MSSQL, or SQLite3 by passing the --database flag when creating a new application

# In order to talk to databases, Phoenix applications use another Elixir package, called Ecto.
# If you don't plan to use databases in your application, you can pass the --no-ecto flag

# Controllers are Elixir modules, and actions are Elixir functions defined in them


# to create a new app: mix phx.new appname
# Phoenix generates the directory structure and all the files we will need for our application.

# To restart a phoenix server - mix phx.server
# By default, Phoenix accepts requests on port 4000

# _build directory holds all the compilation code for building the project, if it is deleted, it rebuilds from scratch. it should not
# be checked into version control

# the config/config.exs file is the entry point for your configuration. It's like python's settings.py
# it imports environment specific configurations for dev, test, prod etc

# deps directory holds all of mix dependencies, This directory must not be checked into version control and it can be
# removed at any time. Removing it will force Mix to download all deps from scratch.

# lib - a directory that holds your application source code. This directory is broken into two subdirectories,
# lib/hello and lib/hello_web. The lib/hello directory will be responsible to host all of your business logic and business domain.
# It typically interacts directly with the database - it is the "Model" in Model-View-Controller (MVC) architecture.
# lib/hello_web is responsible for exposing your business domain to the world, in this case, through a web application.
# It holds both the View and Controller from MVC.

# priv - keeps all resources that are necessary in production but are not directly part of the source code

# test - a directory with all of our application tests. It often mirrors the same structure found in lib.

# NOTE:
- when you first create your Phoenix app using mix phx.new it is possible to specify options that will affect the presence and layout
- of the assets directory.
- In fact, Phoenix apps can bring their own front end tools or not have a front-end at all
- (handy if youre writing an API for example)


# TEMPLATING
# Function components are great for smaller templates and separate files are a good choice when you have a lot of markup or your
# functions start to feel unmanageable

# REQUEST CYCLE
# Register endpoint
# Register router
# Register controller
# Create view

# PLUG
