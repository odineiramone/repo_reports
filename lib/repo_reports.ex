defmodule RepoReports do
  require Logger

  alias Validators.FormatValidator
  alias CodeStoragePlatform.Utils, as: CodePlatformUtils
  alias ReportWebhook.Utils, as: ReportWebhookUtils

  def generate_report(repo_path) when is_binary(repo_path) do
    with {:ok, _} <- FormatValidator.validate(repo_path),
         _ <- Logger.info("Caminho para repositório válido."),
         {:ok, _} <- CodePlatformUtils.repo_exists?(repo_path),
         _ <- Logger.info("Repositório encontrado na plataforma de hospedagem de código"),
         {:ok, repo_and_user_info} <- CodePlatformUtils.get_repo_and_user(repo_path),
         _ <- Logger.info("Relatório de repositório e usuário finalizado."),
         {:ok, issues_reports_list} <- CodePlatformUtils.get_repo_issues(repo_path),
         _ <- Logger.info("Relatório de issues finalizado."),
         {:ok, contributors_reports_list} <- CodePlatformUtils.get_repo_contributors(repo_path),
         _ <- Logger.info("Relatório de contribuidores finalizado."),
         report <-
           Presenters.ReportPresenter.build(
             repo_and_user_info,
             issues_reports_list,
             contributors_reports_list
           ) do
      ReportWebhookUtils.post_report(report)
      Logger.info("Relatório enviado via webhook!")
    end
  end

  def generate_report(_), do: {:error, "o caminho para o repositório precisa ser uma string"}
end
