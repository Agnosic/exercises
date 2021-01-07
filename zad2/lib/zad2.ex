defmodule Zad2 do
  def main(_args) do
    IO.puts("Started with translating binary to decimal")
    IO.puts("To change options type either 'binary' or 'decimal'")

    convert_loop()
  end

  defp convert_loop() do
    text = "" |> IO.gets() |> String.trim()

    Converter
    |> GenServer.call(text)
    |> IO.puts()

    convert_loop()
  end
end
