defmodule Presenters.ReportPresenter do
  def present(%{
        repo_and_user_info: repo_and_user_info,
        issues_reports: issues_reports_list,
        contributors_reports: contributors_reports_list
      }) do
    %{
      report: %{
        user: repo_and_user_info.user,
        repository: repo_and_user_info.repository,
        issues: issues_reports_list,
        contributors: contributors_reports_list
      }
    }
  end

  def present(_), do: {:error, "O mapa recebido é inválido"}
end

# Presenters.ReportPresenter.call(%{repo_and_user_info: %{user: "owner", repository: "repo"}, issues_reports: [["Issue Title", "issue author"]], contributors_reports: [["Contributor Name", "contributor_login", 2]]})
