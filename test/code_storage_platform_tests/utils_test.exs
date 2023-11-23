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
    test "retorna tupla {:ok, %{repository: <repo>, user: <owner>}}" do
      assert CodeStoragePlatform.Utils.get_repo_and_user("owner/repo") ==
               {:ok, %{repository: "repo", user: "owner"}}
    end
  end

  describe "get_repo_issues/1" do
    test "retorna tupla {:ok, %{issues: <issues_list>}}" do
      assert CodeStoragePlatform.Utils.get_repo_issues("owner/repo") ==
               {:ok, [["Issue Title", "user", ["label1", "label2", "label3"]]]}
    end
  end

  describe "get_repo_contributors/1" do
    test "retorna tupla {:ok, %{issues: <issues_list>}}" do
      assert CodeStoragePlatform.Utils.get_repo_contributors("owner/repo") ==
               {:ok, [["John Doe", "login", 1]]}
    end
  end
end
