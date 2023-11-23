defmodule RepoReports do
  alias Validators.FormatValidator
  alias CodeStoragePlatform.Utils, as: CodePlatformUtils
  alias ReportWebhook.Utils, as: ReportWebhookUtils

  def generate_report(repo_path) when is_binary(repo_path) do
    with {:ok, _} <- FormatValidator.validate(repo_path),
         {:ok, _} <- CodePlatformUtils.repo_exists?(repo_path),
         {:ok, repo_and_user_info} <- CodePlatformUtils.get_repo_and_user(repo_path),
         {:ok, issues_reports_list} <- CodePlatformUtils.get_repo_issues(repo_path),
         {:ok, contributors_reports_list} <- CodePlatformUtils.get_repo_contributors(repo_path) do
      %{
        repo_and_user_info: repo_and_user_info,
        issues_reports: issues_reports_list,
        contributors_reports: contributors_reports_list
      }
      |> Presenters.ReportPresenter.present()
      |> ReportWebhookUtils.post_report()
    end
  end

  def generate_report(_), do: {:error, "o caminho para o repositório precisa ser uma string"}
end
