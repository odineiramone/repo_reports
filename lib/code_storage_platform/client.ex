defmodule CodeStoragePlatform.Client do
  @headers [
    Authorization:
      "Bearer " <> Application.compile_env!(:repo_reports, :github)[:authentication_token],
    accept: "application/vnd.github+json"
  ]

  def get_repo(repo_path),
    do: repo_path |> repo_url() |> get!(@headers)

  def get_user(username),
    do: username |> user_url() |> get!(@headers)

  def get_repo_issues(repo_path, options \\ [page: 1, per_page: 100]),
    do: repo_path |> repo_issues_url() |> get!(@headers, options)

  def get_repo_contributors(repo_path, options \\ [page: 1, per_page: 100]),
    do:
      repo_path
      |> repo_contributors_url()
      |> get!(@headers, options)

  defp get!(url, headers, options \\ []), do: http_client().get!(url, headers, options)

  defp repo_url(repo_path), do: base_url() <> "/repos" <> "/" <> repo_path

  defp user_url(username), do: base_url() <> "/users" <> "/" <> username

  defp repo_issues_url(repo_path), do: base_url() <> "/repos" <> "/" <> repo_path <> "/issues"

  defp repo_contributors_url(repo_path),
    do: base_url() <> "/repos" <> "/" <> repo_path <> "/contributors"

  defp base_url, do: Application.fetch_env!(:repo_reports, :github)[:base_url]

  defp http_client, do: Application.fetch_env!(:repo_reports, :http_client)

  def headers() do
    require IEx
    IEx.pry()

    [
      Authorization:
        "Bearer " <> Application.fetch_env!(:repo_reports, :github)[:authentication_token],
      accept: "application/vnd.github+json"
    ]
  end
end
