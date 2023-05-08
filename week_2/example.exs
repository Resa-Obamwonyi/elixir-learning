defmodule Read do
  def read(info) do
    # if info do
    #   elem(info, 1)
    # end

    if {:ok, msg} = info do
      msg
    end

    if {:error, msg} = info do
      msg
    end

  end
end


IO.puts(Read.read({:error, "It Failed"}))
IO.puts(Read.read({:ok, "Successful!!!"}))
