defmodule Friends.OffDayFactory do
  use ExMachina.Ecto, repo: Friends.Repo
  alias Friends.OffDays.OffDay

  # EXPLAIN: How do macros work?
  defmacro __using__(_opts) do
    quote do
      def off_day_factory do
        %OffDay{
          day: "mon",
          type: "half"
        }
      end
    end
  end
end
