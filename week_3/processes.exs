# In elixir, all code run inside processes
# Processes in Elixir are extremely lightweight in terms of memory and CPU (even compared to threads as used in many other programming languages).
# Because of this, it is not uncommon to have tens or even hundreds of thousands of processes running simultaneously.

# to spawn a new process spawn/1
# takes a function which it will execute in another process.
spawn(fn -> 1 + 2 end)

# the above returns a process identifier for a spaqn that is most likely dead.
# The spawned process will execute the given function and exit after the function is done
pid = spawn(fn -> 1 + 2 end)
Process.alive?(pid) # false

# We can retrieve the PID of the current process by calling self/0:
self()
Process.alive?(self()) # true

# SEND AND RECEIVE
# We can send messages to a process with send/2 and receive them with receive/1:

# prints {:hello, "world"}
send(self(), {:hello, "world"})

# prints "world"
receive do
    {:hello, msg} -> msg
    {:world, _msg} -> "won't match"
end

# When a message is sent to a process, the message is stored in the process mailbox.
# The receive/1 block goes through the current process mailbox searching for a message that matches any of the given patterns.
# receive/1 supports guards and many clauses, such as case/2.
# If there is no message in the mailbox matching any of the patterns, the current process will wait until a matching message arrives.
# A timeout can also be specified

# prints "nothing after 1s"
receive do
    {:hello, msg}  -> msg
after
     1_000 -> "nothing after 1s"
end

# INSPECT/1 --> The inspect/1 function is used to convert a data structure’s internal representation into a string, typically for printing
{:hello, pid} -> "Got hello from #{inspect pid}" # can also be inspect(pid)

# FLUSH/0 ---> flush/0 , it flushes and prints all messages in the mailbox
flush()

# LINKING
# spawn_link(function)
# Processes and links play an important role when building fault-tolerant systems.
# Elixir processes are isolated and don’t share anything by default.
# Therefore, a failure in a process will never crash or corrupt the state of another process.
# Links, however, allow processes to establish a relationship in case of failure.
# We often link our processes to supervisors which will detect when a process dies and start a new process in its place

# spawn/1 and spawn_link/1 are the basic primitives for creating processes in Elixir.
# Although we have used them exclusively so far, most of the time we are going to use abstractions that build on top of them

# TASK
# Tasks build on top of the spawn functions to provide better error reports and introspection
Task.start(function)
# Instead of spawn/1 and spawn_link/1, we use Task.start/1 and Task.start_link/1 which return {:ok, pid} rather than just the PID

# STATE
# We can write processes that loop infinitely, maintain state, and send and receive messages

