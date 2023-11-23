defmodule ReportWebhook.Client do
  @headers [{"Content-Type", "application/json"}]

  def post(report) do
    with {:ok, encoded_report} <- Jason.encode(report), do: do_post(encoded_report)
  end

  defp do_post(report), do: http_client().post(url(), report, @headers)

  defp url, do: Application.fetch_env!(:repo_reports, :report_webhook)[:url]

  defp http_client, do: Application.fetch_env!(:repo_reports, :http_client)
end
