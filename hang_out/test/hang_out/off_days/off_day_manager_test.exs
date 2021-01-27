defmodule OffDaysTest do
  use ExUnit.Case
  alias HangOut.OffDays.OffDayManager
  alias HangOut.People.PersonManager
  import HangOutWeb.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(HangOut.Repo)
    person = insert(:person)
    mon = %{day: "Mon", type: "whole", person: person}
    tue = %{day: "Tue", type: "half", person: person}
    wed = %{day: "Wed", type: "whole", person: person}
    insert(:off_day, mon)
    insert(:off_day, tue)
    insert(:off_day, wed)

    {:ok, person: PersonManager.load_off_days(person)}
  end

  test "it updates all the off days for a given person", %{person: person} do
    new_off_days = [
      %{
        day: "Mon",
        type: "half"
      },
      %{
        day: "Tue",
        type: "whole"
      },
      %{
        day: "Wed",
        type: "half"
      }
    ]

    OffDayManager.update_off_days(person.id, new_off_days)
    person = PersonManager.load_off_days(person)
    assert format_off_days(person.off_days) == new_off_days
  end

  def format_off_days(off_days) do
    Enum.map(off_days, fn off_day ->
      %{
        day: off_day.day,
        type: off_day.type
      }
    end)
  end
end
