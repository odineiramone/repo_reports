defmodule RepoReportsTest do
  use ExUnit.Case

  describe "generate_report/1" do
    test "inicia o processo de gerar relatório caso o parâmetro seja uma string válida" do
      assert RepoReports.generate_report("owner/repo") ==
               {:ok,
                "\"This URL has no default content configured. <a href=\\\"https://webhook.site/#!/d444f512-d0c4-4837-9504-83e77ba926a4\\\">View in Webhook.site</a>.\"\n"}
    end

    test "retorna {:error, <mensagem>} caso o parâmetro não seja uma string" do
      assert RepoReports.generate_report(123) ==
               {:error, "o caminho para o repositório precisa ser uma string"}
    end
  end
end
