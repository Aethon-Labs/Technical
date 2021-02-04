defmodule HangOut.ScheduleSync.ScheduleSync.Worker do
  @moduledoc """
  Send a request to a webhook every hour to update schedules from other services
  """
  use GenServer
  require Logger

  # TECHNICAL-TODO: Get this to call this URL every hour: https://google.com/

  def start_link do
    GenServer.start_link(__MODULE__, :nostate, name: __MODULE__)
  end

  # Genserver callbacks

  def init(_arg) do
    Logger.info("ScheduleSync Started")

    {:ok, :nostate, {:continue, :schedule}}
  end

  def handle_continue(:schedule, state) do
    # Get the current UTC datetime
    now = Timex.now()

    next_check =
      now
      # Add an hour
      |> Timex.shift(hours: 1)
      |> Map.put(:minute, 0)

    time = DateTime.diff(next_check, now, :millisecond)

    Process.send_after()

    {:noreply, state}
  end

  def handle_continue(message, state) do
    Logger.warn("Got unknown message: #{inspect(message)}.")

    {:noreply, state}
  end

  def handle_info({:send_messages, %DateTime{}}, state) do

    {:noreply, state, {:continue, :schedule}}
  end

  def handle_info(message, state) do
    {:noreply, state}
  end
end
