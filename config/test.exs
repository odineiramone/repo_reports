import Config

config :repo_reports, :http_client, CodeStoragePlatformMox.ClientMock
config :logger, level: :warning
