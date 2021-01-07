defmodule Zad1 do
  @spec main(String.t()) :: String.t()
  def main(file) do
    File.stream!(file)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&check_line/1)
    |> Enum.to_list()
    |> get_information()
    |> save_output()
    |> case do
      :ok -> "output.txt generated"
      {:error, msg} -> msg
    end
    |> IO.puts()
  end

  @spec check_line(String.t()) :: String.t() | nil
  defp check_line("00000000"), do: nil

  defp check_line(<<_::24, bit::8, _::24, bit::8>> = line) when bit in [?0, ?1], do: line

  defp check_line(_line), do: nil

  @spec get_information(list) :: Information.t()
  defp get_information(results) when is_list(results),
    do: %Information{
      objects_count: Enum.count(results),
      objects_with_error_count: results |> Enum.filter(&is_nil(&1)) |> Enum.count(),
      valid_objects: Enum.filter(results, &(!is_nil(&1)))
    }

  @spec save_output(Information.t()) :: :ok | {:error, :file.posix()}
  defp save_output(%Information{
         objects_count: objects_count,
         objects_with_error_count: objects_with_error_count,
         valid_objects: valid_objects
       }),
       do:
         File.write("output.txt", """
         #{objects_count}
         #{objects_with_error_count}
         #{Enum.join(valid_objects, " ")}
         """)
end
