defmodule ValidatorsTests.FormatValidatorTest do
  use ExUnit.Case

  describe "validate/1" do
    test "retorna {:ok, <parametro>} caso o parâmetro seja válido" do
      assert Validators.FormatValidator.validate("owner/repo") == {:ok, "owner/repo"}
    end

    test "retorna {:error, <mensagem>} caso o parâmetro seja inválido" do
      assert Validators.FormatValidator.validate("owner repo") ==
               {:error, "A string deve seguir o formato <string>/<string>"}
    end
  end
end
