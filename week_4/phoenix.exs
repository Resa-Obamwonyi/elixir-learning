Phoneix is a web development framework, written in Elixir, which implements server side MVC pattern
Hex is the package manager needed to get a phoenix app running
mix help phx.new --> to get help on phoenix

# Phoenix configures apps to use postgres dbs by default,
# but we can switch to MySQL, MSSQL, or SQLite3 by passing the --database flag when creating a new application

# In order to talk to databases, Phoenix applications use another Elixir package, called Ecto.
# If you don't plan to use databases in your application, you can pass the --no-ecto flag

Controllers are Elixir modules, and actions are Elixir functions defined in them

# to create a new app: mix phx.new appname
# Phoenix generates the directory structure and all the files we will need for our application.

# To restart a phoenix server - mix phx.server
# By default, Phoenix accepts requests on port 4000

The _build directory holds all the compilation code for building the project, if it is deleted, it rebuilds from scratch. it should not
be checked into version control

# the config/config.exs file is the entry point for your configuration. It's like python's settings.py
# it imports environment specific configurations for dev, test, prod etc

# deps directory holds all of mix dependencies, This directory must not be checked into version control and it can be
# removed at any time. Removing it will force Mix to download all deps from scratch.

lib - a directory that holds your application source code. This directory is broken into two subdirectories,
lib/hello and lib/hello_web. The lib/hello directory will be responsible to host all of your business logic and business domain.
It typically interacts directly with the database - it is the "Model" in Model-View-Controller (MVC) architecture.
lib/hello_web is responsible for exposing your business domain to the world, in this case, through a web application.
It holds both the View and Controller from MVC.

priv - keeps all resources that are necessary in production but are not directly part of the source code

test - a directory with all of our application tests. It often mirrors the same structure found in lib.

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

# CONTROLLERS
- These are intermidiary modules with functions calles actions which are invoked from the router in response to http requests.
- Actions gather all necessary data and perform all necessary steps before invoking the view layer to render a template or return a JSON response
- Controller action names must match a route defined in the router, but there is a naming convention
        index - renders a list of all items of the given resource type
        show - renders an individual item by ID
        new - renders a form for creating a new item
        create - receives parameters for one new item and saves it in a data store
        edit - retrieves an individual item by ID and displays it in a form for editing
        update - receives parameters for one edited item and saves the item to a data store
        delete - receives an ID for an item to be deleted and deletes it from a data store

- Each of these actions takes two parameters, which will be provided by Phoenix behind the scenes. The first param is always conn.
- Conn is a struct which hold information about the request such as the host, path elements, query, port etc
- The second parameter is params. This is a map which holds any parameters passed along in the HTTP request
- When we do not need the params, simply calling it as _params will solve the problem
- We can compose our own rendering responses using the Plug.Conn.send_resp/3 function, e.g send_resp(conn, 201, "created")
- To be specific about the content type, we can use put_resp_content_type/2 in conjunction with send_resp/3.

def home(conn, _params) do
  conn
  |> put_resp_content_type("text/plain")
  |> send_resp(201, "")
end


- put_flash and clear_flash are used to add and clear pop up flash messages, either as error or info.

# ROUTING
- Routes match http requests to controller actions.
- Run mix phx.routes to get a list of all the routes available in yout application
- If we do not need all given routes, we can be selective using the :only and :except options to filter specific actions e.g
      resources "/posts", PostController, only: [:index, :show]
      resources "/comments", CommentController, except: [:delete]
- using ~p you can write route paths in controllers, tests and templates e.g ~p"/home"
      <.link href={~p"/comments"}>View Comments</.link>
      redirect(conn, to: ~p"/comments/#{comment}")
- Pipelines are a series of plugs that can be attached to specific scopes. Phoenix defines two pipelines by default, :browser and :api
- Routes can be organized via pipelines e.g using specific pipelines for auth before access is granted to certain endpoints
- Routes which begin with an http verb name expand to a single clause of the match function
- Routes declared with "resources" expand to 8 clauses of the match function


# CONTEXTS
- Contexts are dedicated modules that expose and group related functionality, for example the Elixir logger is made of multiple modules,
    but we never interact with those modules directly.
    We call the Logger module the context, exactly because it exposes and groups all of the logging functionality
- Contexts often encapsulate data access and data validation. They often talk to a database or APIs.
- Overall, think of them as boundaries to decouple and isolate parts of your application
- Example "mix phx.gen.html Catalog Product products title:string description:string price:decimal views:integer" generates web files and context files
    As well as product schema
- Update db repo using "mix ecto.migrate"


# GENERATORS
- mix phx.gen lists all available phoenix generators
- mix phx.gen.html generates controllers, html views and context for an html resource
- If you switch html to json, you would get the equivalent, but with json views and resources

- e.g mix phx.gen.html Accounts User users name:string age:integer
- The first argument is the context module followed by the schema module and its plural name (used as the schema table name).

- Overall, this generator will add the following files to lib/:
      - a context module in lib/app/accounts.ex for the accounts API
      - a schema in lib/app/accounts/user.ex, with a users table
      - a controller in lib/app_web/controllers/user_controller.ex
      - an HTML view collocated with the controller in lib/app_web/controllers/user_html.ex
      - default CRUD templates in lib/app_web/controllers/user_html
      - A migration file for the repository and test files for the context and controller features will also be generated.
- You can customize the web module namespace by passing the --web flag with a module name e.g mix phx.gen.html Sales User users --web Sales
- The --context-app option may be supplied to the generator to define the location of the web files, else default is used
      - mix phx.gen.html Sales User users --context-app warehouse

- The mix phx.gen.html packs a punch, it provides full html views and api and database functionality for adding, deleting and getting data from the database.
- Phoenix generates generic functions, such as list_products and update_product, but they only serve as a basis for you to grow your business logic and application from


# COMPONENTS
- Any function that accepts an assigns parameter and returns a HEEx template is a function component (call the ~H sigil)
- Function components are defined with the Phoenix.Component module
- Function components are the essential building block for any kind of markup-based template rendering
- Function components can be embedded from template files
- The attr keyword, provided by Phoenix.Component, is used to define the attributes/assigns that a function component expects.

    attr :messenger, :string

      def greet(assigns) do
        ~H"""
        <h2>Hello World, from <%= @messenger %>!</h2>
        """
      end
- By declaring attributes, Phoenix will warn if we call the <.greet /> component without passing attributes.
      If an attribute is optional, you can specify the :default option with a value:


# HEEX
- This is the phoenix templating language. HEEX stands for "HTML+EEx".
- EEx is an Elixir library that uses <%= expression %> to execute Elixir expressions and interpolate their results into the template
- It also comes with handy html extensions
- HEEx supports shorthand syntax for if and for expressions via the special :if and :for attributes
      - <div :if={@some_condition}>...</div>
      - <ul>
            <li :for={item <- @items}><%= item.name %></li>
        </ul>
        
- HEEx also warns about errors in the html parts of the template
