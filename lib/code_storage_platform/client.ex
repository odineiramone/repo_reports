defmodule CodeStoragePlatform.Client do
  def get_repo(repo_path), do: repo_path |> repo_url() |> http_client().get!()

  def get_repo_issues(repo_path), do: repo_path |> repo_issues_url() |> http_client().get!()

  defp repo_url(repo_path), do: base_url() <> "/repos" <> "/" <> repo_path

  defp repo_issues_url(repo_path), do: base_url() <> "/repos" <> "/" <> repo_path <> "/issues"

  defp base_url, do: Application.fetch_env!(:repo_reports, :github)[:base_url]

  defp http_client, do: Application.fetch_env!(:repo_reports, :http_client)
end
