defmodule Presenters.ReportPresenter do
  def build(repo_and_user_info, issues_reports_list, contributors_reports_list) do
    %{
      report: %{
        user: repo_and_user_info.user,
        repository: repo_and_user_info.repository,
        issues: issues_reports_list,
        contributors: contributors_reports_list
      }
    }
  end
end
