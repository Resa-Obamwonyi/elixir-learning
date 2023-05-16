# A Supervisor is a process that supervises other processes and restarts them whenever they crash
- A supervisor is a process which supervises other processes, which we refer to as child processes.
- The act of supervising a process includes three distinct responsibilities. The first one is to start child processes.
- Once a child process is running, the supervisor may restart a child process, either because it terminated abnormally or because a certain
    condition was reached.
- For example, a supervisor may restart all children if any child dies.
- Finally, a supervisor is also responsible for shutting down the child processes when the system is shutting down

- A supervision strategy dictates what happens when one of the children crashes, there are many different strategies
- :one_for_one means that if a child process dies, it will be the only one restarted

# Once the supervisor starts, it will traverse the list of children and it will invoke the child_spec/1 function on each module.
# The child_spec/1 function returns the child specification which describes how to start the process,
# if the process is a worker or a supervisor, if the process is temporary, transient or permanent and so on.
# The child_spec/1 function is automatically defined when we use Agent, use GenServer, use Supervisor, etc
- Once the supervisor starts, it also starts all of its children
- Now that processes are started by the supervisor, we have to directly ask the supervisor who its children are,
- and fetch the pid from the returned list of children. In practice, doing so every time would be very expensive.
- To address this, we often give names to processes, allowing them to be uniquely identified in a single machine from anywhere in our code

# Starting a supervisor
- Each application in our system can be started and stopped
- The rules for starting and stopping an app are defined in the .app file
- When we invoke iex -S mix, Mix compiles our app and starts it
# Whenever we invoke iex -S mix, Mix automatically starts our application by calling Application.start(:kv).

- To invoke mix and not start the app, flags can be added, iex -S mix run --no-start
- By defining our own supervisor, we provide more structure on how we initialize, shutdown and supervise processes in our applications,
- aligning our production code and tests with best practices.


# Applications are the idiomatic way to package software in Erlang/OTP.
# To get the idea, they are similar to the "library" concept common in other programming languages,
# but with some additional characteristics

- A supervisor is a process which supervises other processes, which we refer to as child processes.
- Supervisors are used to build a hierarchical process structure called a supervision tree.
- Supervision trees provide fault-tolerance and encapsulate how our applications start and shutdown.
