# In Elixir, nothing is shared by default!
# If we want to share information, we use the following
- Processes and message passing
- Erlang Term Storage (ETS)

# AGENTS
# These are simple wrappers around state, if all you want is to keep state, use agents.

# start abn agent with an empty list
{:ok, agent} = Agent.start_link fn -> [] end
# update state(list) with "eggs"
Agent.update(agent, fn list -> ["eggs" | list] end)
# get items from list, returns "eggs"
Agent.get(agent, fn list -> list end)
# terminate the agent process
Agent.stop(agent)


# continued with lib and test folders
