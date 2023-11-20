defmodule CodeStoragePlatformTests.UtilsTest do
  use ExUnit.Case

  describe "repo_exists?/1" do
    test "retorna {:ok, <parametro>} caso o repositório remoto exista" do
      assert CodeStoragePlatform.Utils.repo_exists?("owner/repo") == {:ok, "owner/repo"}
    end

    test "retorna {:error, <parametro>} caso o repositório remoto exista" do
      assert CodeStoragePlatform.Utils.repo_exists?("owner/repo_not_found") ==
               {:error, "owner/repo_not_found"}
    end
  end
end
