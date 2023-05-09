# Option 1
defmodule Read do
  def read({:ok, msg}) do
    msg
  end

  def read({:error, msg}) do
    msg
  end

  def read(_anything_else) do
    "Unknown Value"
  end
end


# Option 2
defmodule Read do
  def read(info) do
    case info do
      {:ok, msg} -> msg
      {:error, msg} -> msg
      _unknown -> "Unknown Value"
    end
  end
end

# Option 3


IO.puts(Read.read({:error, "It Failed"})) # It Failed
IO.puts(Read.read({:ok, "Successful!!!"})) # Successful!!!
IO.puts(Read.read({:something_weird})) # Unknown Value
