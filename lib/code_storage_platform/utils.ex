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
    with raw_response <- Client.get_repo(repo_path),
         processed_response <- process_response(raw_response),
         do: {:ok, processed_response}
  end

  defp check_if_repo_exists(%{status_code: 200} = _raw_response), do: :ok
  defp check_if_repo_exists(_), do: :error

  def process_response(%{body: raw_body} = _raw_response) do
    with parsed_body <- Jason.decode!(raw_body),
         repo_name <- get_in(parsed_body, ["name"]),
         repo_owner <- get_in(parsed_body, ["owner", "login"]),
         do: %{user: repo_owner, repository: repo_name}
  end

  def process_response(_), do: :error
end
