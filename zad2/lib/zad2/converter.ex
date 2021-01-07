defmodule Zad2.Converter do
  use GenServer

  def start_link(number_system) do
    GenServer.start_link(__MODULE__, number_system, name: Converter)
  end

  @impl true
  def init(number_system) do
    {:ok, number_system}
  end

  @number_systems ["binary", "decimal"]

  @impl true
  def handle_call(number_system, _from, _state) when number_system in @number_systems,
    do: {:reply, "Changed system to #{number_system}", number_system}

  @failure_message "Wrong number. Must be "

  def handle_call(number, _from, "binary" = system) do
    response =
      case Integer.parse(number, 2) do
        {number, ""} -> Integer.to_string(number, 10)
        _ -> @failure_message <> system
      end

    {:reply, response, system}
  end

  def handle_call(number, _from, "decimal" = system) do
    response =
      case Integer.parse(number, 10) do
        {number, ""} -> Integer.to_string(number, 2)
        _ -> @failure_message
      end

    {:reply, response, system}
  end
end
