defmodule Validators.FormatValidator do
  def validate(string) do
    case String.match?(string, ~r/\S+\/\S+/) do
      true -> {:ok, string}
      false -> {:error, "A string deve seguir o formato <string>/<string>"}
    end
  end
end
