defmodule DNScreen.Deduplication do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> MapSet.new end, name: __MODULE__)
  end

  def register(id) do
    Agent.update(__MODULE__, &MapSet.put(&1, id))
  end

  def registered?(id) do
    Agent.get(__MODULE__, &MapSet.member?(&1, id))
  end
end
