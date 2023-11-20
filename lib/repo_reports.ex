defmodule RepoReports do
  alias Validators.FormatValidator
  alias CodeStoragePlatform.Utils

  def get_report(repo_path) when is_binary(repo_path) do
    with {:ok, _} <- FormatValidator.validate(repo_path),
         :ok <- Utils.repo_exists?(repo_path),
         do: get_the_report(repo_path)
  end

  def get_report(_), do: {:error, "o caminho para o repositório precisa ser uma string"}

  defp get_the_report(repo_path) do
    {:ok, repo_path}
  end
end
