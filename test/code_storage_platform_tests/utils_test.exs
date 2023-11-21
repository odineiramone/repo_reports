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

  describe "get_repo_and_user/1" do
    test "retorna mapa %{repository: <repo>, user: <owner>}" do
      assert CodeStoragePlatform.Utils.get_repo_and_user("owner/repo") ==
               {:ok, %{repository: "repo", user: "owner"}}
    end
  end
end
