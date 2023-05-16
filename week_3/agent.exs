# In Elixir, nothing is shared by default!
# If we want to share information, we use the following
- Processes and message passing
- Erlang Term Storage (ETS)

# AGENTS NOTES
# These are simple wrappers around state, if all you want is to keep state, use agents.
# These are used to manage states
# Used to store state in memory
# Similar to GenServers, but cannot receive custom messages


# start abn agent with an empty list
{:ok, agent} = Agent.start_link fn -> [] end
# update state(list) with "eggs"
Agent.update(agent, fn list -> ["eggs" | list] end)
# get items from list, returns "eggs"
Agent.get(agent, fn list -> list end)
# terminate the agent process
Agent.stop(agent)


# continued with lib and test folders

# QUESTIONS
1. When to use Agents or Genservers // Which is better?
2. Are supervisors mandatory for every application?

- if you are only using state, use agent
- if you want to receive messages and modifiy based on what you receive, use genservers
