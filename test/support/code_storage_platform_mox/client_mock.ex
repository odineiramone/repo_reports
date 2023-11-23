defmodule CodeStoragePlatformMox.ClientMock do
  @fixtures_path "test/support/code_storage_platform_mox/fixtures/"

  def get!("https://api.github.com/repos/owner/repo") do
    %{
      status_code: 200,
      body: get_fixture("repo_success.json")
    }
  end

  def get!("https://api.github.com/repos/owner/repo/issues") do
    %{
      body: get_fixture("issues.json")
    }
  end

  def get!("https://api.github.com/repos/owner/repo/contributors") do
    %{
      body: get_fixture("contributors.json")
    }
  end

  def get!("https://api.github.com/users/login") do
    %{
      body: get_fixture("user.json")
    }
  end

  def get!("https://api.github.com/repos/owner/repo_not_found"), do: %{status_code: 404}

  def post(_url, _report, _headers) do
    {:ok,
     %{
       status_code: 200,
       body: get_fixture("webhook.json")
     }}
  end

  defp get_fixture(file_path) do
    with {:ok, json_content} <- File.read(@fixtures_path <> file_path), do: json_content
  end
end
