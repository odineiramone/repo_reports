defmodule CodeStoragePlatform.Utils do
  alias CodeStoragePlatform.Client

  def repo_exists?(repo_path) do
    with response <- Client.get_repo(repo_path),
         :ok <- check_if_repo_exists(response) do
      {:ok, repo_path}
    else
      :error ->
        {:error, "O repositório " <> repo_path <> " não existe."}
    end
  end

  def get_repo_and_user(repo_path) do
    with %{body: raw_body} <- Client.get_repo(repo_path),
         parsed_body <- Jason.decode!(raw_body),
         repo_name <- get_in(parsed_body, ["name"]),
         repo_owner <- get_in(parsed_body, ["owner", "login"]),
         do: {:ok, %{user: repo_owner, repository: repo_name}}
  end

  def get_repo_issues(repo_path) do
    with %{body: raw_body} <- Client.get_repo_issues(repo_path),
         parsed_body <- Jason.decode!(raw_body),
         do: {:ok, Enum.map(parsed_body, &generate_issue_report/1)}
  end

  def get_repo_contributors(repo_path) do
    with %{body: raw_body} <- Client.get_repo_contributors(repo_path),
         parsed_body <- Jason.decode!(raw_body),
         do: {:ok, Enum.map(parsed_body, &generate_contributor_report/1)}
  end

  defp generate_contributor_report(issue) do
    [
      get_user_name(issue),
      get_in(issue, ["login"]),
      get_in(issue, ["contributions"])
    ]
  end

  defp get_user_name(%{"login" => username}) do
    with %{body: raw_body} <- Client.get_user(username),
         parsed_body <- Jason.decode!(raw_body),
         do: parsed_body["name"]
  end

  defp generate_issue_report(issue) do
    [
      get_in(issue, ["title"]),
      get_in(issue, ["user", "login"]),
      get_in(issue, ["labels"]) |> Enum.map(fn label -> label["name"] end)
    ]
  end

  defp check_if_repo_exists(%{status_code: 200} = _raw_response), do: :ok
  defp check_if_repo_exists(_), do: :error
end
