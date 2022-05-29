defmodule Wabanex.IMC do


  def calculate(filename) do
      filename
      |> File.read()
      |> handle_file()

  end

  defp handle_file({:error, reason}) do
    {:error, "Error while opening the file reason #{reason}"}
  end

  defp handle_file({:ok, content}) do
    content
    |> parse_file()
  end

  def parse_file(data) do
    data
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.into(%{})

  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  def calculate_imc([name, weight, height]) do
    {name, weight / (height * height)}
  end
end
