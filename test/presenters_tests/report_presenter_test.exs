defmodule PresentersTests.ReportPresenterTest do
  use ExUnit.Case

  describe "build/1" do
    test "retorna {:report: <parametro>} caso o parâmetros seja um mapa válido" do
      assert Presenters.ReportPresenter.build(
               %{user: "owner", repository: "repo"},
               [["Issue Title", "issue author"]],
               [["Contributor Name", "contributor_login", 2]]
             ) == %{
               report: %{
                 user: "owner",
                 repository: "repo",
                 issues: [["Issue Title", "issue author"]],
                 contributors: [["Contributor Name", "contributor_login", 2]]
               }
             }
    end
  end
end
