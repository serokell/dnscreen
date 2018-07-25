defmodule DNScreen.Slack do
  def incoming_webhook_url do
    Application.get_env(:dnscreen, :incoming_webhook_url)
  end

  def send_message(args) do
    HTTPoison.post!(incoming_webhook_url(), Poison.encode!(args))
  end

  def action_to_color(_) do
    "#f00"
  end

  def format(%{"actor" => %{"pretty" => email, "id" => user_id},
               "name" => action, "data" => data}) do
    %{
      "author_name" => email,
      "author_icon" => "https://i2.wp.com/cdn.dnsimple.com/assets/website/gravatar-default.png?ssl=1",
      "author_link" => "",
      "color" => action_to_color(action),
      "fallback" => "TODO",
      "fields" => [
        %{"title" => "foo", "value" => "bar", "short" => true} 
      ],
      "footer" => "DNSimple",
      "footer_icon" => "https://dnsimple.com/assets/favicon-655132b58b83af3a4823108f3ce560098b7c5d076a62d460baf0b70b08292ee6.ico",
      "image_url" => "http://my-website.com/path/to/image.jpg",
      "pretext" => "#{email} [#{user_id}] #{description(action)}",
      "text" => "hello",
      "title" => "a.serokell.com",
      "title_link" => "https://dnsimple.com/a/82633/domains/serokell.com/records",
      "ts" => 19199191
    }
  end

  def description("account.update"), do: "updated account details"
  def description("account.billing_settings_update"), do: "updated account billing settings"
  def description("account.payment_details_update"), do: "updated account payment details"
  def description("account.add_user"), do: "added user"
  def description("account.remove_user"), do: "added user"
  def description("domain.auto_renewal_enable"), do: "enabled auto-renewal"
  def description("domain.auto_renewal_disable"), do: "disabled auto-renewal"
  def description("domain.create"), do: "created a domain zone"
  def description("domain.delete"), do: "deleted a domain zone"
  def description(_), do: "made an unknown action"

  def send_payload(payload) do
    send_message(%{"attachments" => [format(payload)]})
  end
end
