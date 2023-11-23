defmodule PresentersTests.ReportPresenterTest do
  use ExUnit.Case

  describe "validate/1" do
    test "retorna {:ok, <parametro>} caso o parâmetros seja um mapa válido" do
      params = %{
        repo_and_user_info: %{user: "owner", repository: "repo"},
        issues_reports: [["Issue Title", "issue author"]],
        contributors_reports: [["Contributor Name", "contributor_login", 2]]
      }

      assert Presenters.ReportPresenter.present(params) == %{
               report: %{
                 user: "owner",
                 repository: "repo",
                 issues: [["Issue Title", "issue author"]],
                 contributors: [["Contributor Name", "contributor_login", 2]]
               }
             }
    end

    test "retorna {:error, <mensagem>} caso o parâmetro seja um mapa inválido" do
      params = %{
        repo_and_user_info: %{user: "owner", repository: "repo"},
        issues_reports: [["Issue Title", "issue author"]],
        contributors_report: [["Contributor Name", "contributor_login", 2]]
      }

      assert Presenters.ReportPresenter.present(params) ==
               {:error, "O mapa recebido é inválido"}
    end
  end
end
