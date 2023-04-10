defmodule HumanTool.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Bandit, plug: HumanTool.Plugin}
    ]
    opts = [strategy: :one_for_one, name: HumanTool.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
