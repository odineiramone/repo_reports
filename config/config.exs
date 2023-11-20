import Config

config :repo_reports, :github, base_url: "https://api.github.com"

config :repo_reports, :http_client, HTTPoison

import_config "#{config_env()}.exs"
