defmodule DNScreen.Slack.Attachment do
  def format(%{"actor" => %{"pretty" => email, "id" => user_id},
               "name" => action, "data" => data}) do
    %{"fallback" => "", "text" => "#{email} [#{user_id}] #{description(action)}"}
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
end
