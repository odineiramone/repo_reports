defmodule CodeStoragePlatform.Utils do
  alias CodeStoragePlatform.Client

  def repo_exists?(repo_path) do
    with response <- Client.get_repo(repo_path),
         :ok <- check_if_repo_exists(response) do
      {:ok, repo_path}
    else
      :error ->
        {:error, repo_path}
    end
  end

  def get_repo_and_user(repo_path) do
    with %{body: raw_body} <- Client.get_repo(repo_path),
         parsed_body <- Jason.decode!(raw_body),
         repo_name <- get_in(parsed_body, ["name"]),
         repo_owner <- get_in(parsed_body, ["owner", "login"]),
         do: {:ok, %{user: repo_owner, repository: repo_name}}
  end

  defp check_if_repo_exists(%{status_code: 200} = _raw_response), do: :ok
  defp check_if_repo_exists(_), do: :error
end
