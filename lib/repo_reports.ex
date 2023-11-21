defmodule RepoReports do
  alias Validators.FormatValidator
  alias CodeStoragePlatform.Utils

  def get_report(repo_path) when is_binary(repo_path) do
    with {:ok, _} <- FormatValidator.validate(repo_path),
         {:ok, _} <- Utils.repo_exists?(repo_path),
         {:ok, repo_and_user_info} <- Utils.get_repo_and_user(repo_path),
         issues_reports_list <- Utils.get_repo_issues(repo_path),
         contributors_reports_list <- Utils.get_repo_contributors(repo_path) do
      %{
        user: repo_and_user_info.user,
        repository: repo_and_user_info.repository,
        issues: issues_reports_list,
        contributors: contributors_reports_list
      }
    end
  end

  def get_report(_), do: {:error, "o caminho para o repositório precisa ser uma string"}
end
