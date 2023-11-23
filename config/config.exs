import Config

config :repo_reports, :github, base_url: "https://api.github.com"

config :repo_reports, :report_webhook, url: System.get_env("REPORTS_WEBHOOK_URL")

config :repo_reports, :http_client, HTTPoison

import_config "#{config_env()}.exs"
