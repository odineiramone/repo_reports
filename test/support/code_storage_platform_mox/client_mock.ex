defmodule CodeStoragePlatformMox.ClientMock do
  def get!("https://api.github.com/repos/owner/repo"), do: %{status_code: 200}
  def get!("https://api.github.com/repos/owner/repo_not_found"), do: %{status_code: 404}
end
