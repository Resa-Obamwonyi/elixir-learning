# the core Phoenix components like endpoints, routers, and controllers are all just plugs internally
# the plug is a unification module/abstraction layer for connection adapters

# FUNCTION PLUG
- In order to be a function plug, a function must accept a connection struct as its first argument and connection options as second argument
- It must also return a connection struct
- Function plugs are plugged by passing the function name as an atom

# MODULE PLUG
- This is defined in a module and only needs two functions implemented.
- init/1 which initializes any arguments or options to be passed to call/2
- call/2 which carries out the connection transformation. This is a function plug like above.
- The assign/3 is a part of the Plug.Conn module and it is how we store values in the conn data structure.

# Where to assign plugs
- The endpoint, router and controllers in Phoenix

# THE PLUG CONNECTION - Plug.Conn
- This module defines a struct and the main functions for working with requests and responses in an http connection
- In Plug, a "session" is a place to store data that persists from one request to the next.
- Typically, this data is stored in a cookie using Plug.Session.COOKIE
- Assigns is for storing data to be accessed during the current request, and the session is for storing data to be accessed in subsequent requests.

