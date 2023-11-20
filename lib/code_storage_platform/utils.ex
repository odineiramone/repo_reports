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

  defp check_if_repo_exists(%{status_code: 200}), do: :ok
  defp check_if_repo_exists(_), do: :error
end
