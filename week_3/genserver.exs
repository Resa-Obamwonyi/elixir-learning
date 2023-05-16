# A GenServer is a process that invokes a limited set of functions under specific conditions.
# short for Generic Server

def put(bucket, key, value) do
  # Here is the client code
  Agent.update(bucket, fn state ->
    # Here is the server code
    Map.put(state, key, value)
  end)
  # Back to the client code
end

# In a GenServer, the code above would be two separate functions, roughly like this:
def put(bucket, key, value) do
  # Send the server a :put "instruction"
  GenServer.call(bucket, {:put, key, value})
end

# Server callback

def handle_call({:put, key, value}, _from, state) do
  {:reply, :ok, Map.put(state, key, value)}
end



# NOTES
# These can be used to send and receive messages as well as store state
# There are two types of requests you can send to a GenServer: calls and casts.
# Calls are synchronous and the server must send a response back to such requests. While the server computes the response,
      # the client is waiting.
# Casts are asynchronous: the server won’t send a response back and therefore the client won’t wait for one.
# Both requests are messages sent to the server, and will be handled in sequence.

# A GenServer is implemented in two parts: the client API and the server callbacks
