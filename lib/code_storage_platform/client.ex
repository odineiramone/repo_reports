defmodule CodeStoragePlatform.Client do
  def get_repo(repo_path) do
    repo_path
    |> repo_url()
    |> http_client().get!()
  end

  defp repo_url(repo_path) do
    base_url() <> "/repos" <> "/" <> repo_path
  end

  defp base_url, do: Application.fetch_env!(:repo_reports, :github)[:base_url]

  defp http_client, do: Application.fetch_env!(:repo_reports, :http_client)
end
