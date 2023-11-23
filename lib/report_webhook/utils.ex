defmodule ReportWebhook.Utils do
  alias ReportWebhook.Client

  def post_report(%{report: report}) do
    with {:ok, encoded_report} <- Jason.encode(report),
         %{status_code: 200, body: body} <- Client.post(encoded_report) do
      {:ok, Jason.decode!(body)}
    else
      {:ok, result} ->
        {:error, result}
    end
  end

  def post_report(_), do: {:error, "você deve passar um mapa no formato %{report: <report>}"}
end
