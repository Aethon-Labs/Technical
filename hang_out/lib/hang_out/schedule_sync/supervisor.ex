defmodule HangOut.ScheduleSync.ScheduleSync.Supervisor do
  use Supervisor

  alias HangOut.ScheduleSync.Worker

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, [])
  end

  @impl true
  def init(_args) do
    children = [
      %{
        id: Worker,
        start: {Worker, :start_link, []}
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
