defmodule RepoReportsTest do
  use ExUnit.Case

  describe "get_report/1" do
    test "retorna mapa caso o parâmetro seja uma string" do
      assert RepoReports.get_report("owner/repo") == {:ok, %{repository: "repo", user: "owner"}}
    end

    test "retorna {:error, <mensagem>} caso o parâmetro não seja uma string" do
      assert RepoReports.get_report(123) ==
               {:error, "o caminho para o repositório precisa ser uma string"}
    end
  end
end
