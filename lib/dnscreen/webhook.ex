alias DNScreen.Message
alias DNScreen.Slack

defmodule DNScreen.Webhook do
  import Plug.Conn
  
  def init(options), do: options

  def call(conn, _) do
    {:ok, body, conn} = read_body(conn)
    Slack.send_payload(Poison.decode!(body))
    send_resp(conn, 200, "")
  end
end
