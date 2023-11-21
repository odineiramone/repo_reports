defmodule CodeStoragePlatform.Client do
  def get_repo(repo_path), do: repo_path |> repo_url() |> http_client().get!()

  def get_user(username), do: username |> user_url() |> http_client().get!()

  def get_repo_issues(repo_path), do: repo_path |> repo_issues_url() |> http_client().get!()

  def get_repo_contributors(repo_path),
    do: repo_path |> repo_contributors_url() |> http_client().get!()

  defp repo_url(repo_path), do: base_url() <> "/repos" <> "/" <> repo_path

  defp user_url(username), do: base_url() <> "/users" <> "/" <> username

  defp repo_issues_url(repo_path), do: base_url() <> "/repos" <> "/" <> repo_path <> "/issues"

  defp repo_contributors_url(repo_path),
    do: base_url() <> "/repos" <> "/" <> repo_path <> "/contributors"

  defp base_url, do: Application.fetch_env!(:repo_reports, :github)[:base_url]

  defp http_client, do: Application.fetch_env!(:repo_reports, :http_client)
end
