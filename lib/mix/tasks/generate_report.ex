defmodule Mix.Tasks.GenerateReport do
  use Mix.Task

  require Logger

  def run(args) do
    Mix.Task.run("app.start")

    Logger.info("Iniciando...")
    Enum.join(args, " ") |> RepoReports.generate_report()
    Logger.info("Tarefa finalizada.")
  end
end
