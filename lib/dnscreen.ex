alias DNScreen.Deduplication
alias DNScreen.Webhook

defmodule DNScreen do
  use Application

  def cowboy_options do
    Application.get_env(:dnscreen, :cowboy_options)
  end

  def start(_, _) do
    children = [
      {Plug.Adapters.Cowboy2, plug: Webhook, scheme: :http, options: cowboy_options()},
      Deduplication
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
