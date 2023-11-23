defmodule ReportWebhook.Utils do
  alias ReportWebhook.Client

  def post_report(%{report: report}) do
    case Client.post(report) do
      {:ok, %{body: body}} -> {:ok, body}
      {_, %{body: body}} -> {:error, body}
    end
  end

  def post_report(_), do: {:error, "você deve passar um mapa no formato %{report: <report>}"}
end
