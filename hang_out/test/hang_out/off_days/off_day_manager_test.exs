defmodule OffDaysTest do
  use ExUnit.Case
  alias HangOut.OffDays.OffDayManager
  alias HangOut.People.PersonManager

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(HangOut.Repo)
  end

  test "it updates all the off days for a given person" do
    {:ok, person} =
      %{first_name: "Bobby", last_name: "Jones"}
      |> PersonManager.create_person()

    new_off_days = [
      %{
        day: "mon",
        type: "half"
      },
      %{
        day: "tue",
        type: "whole"
      },
      %{
        day: "wed",
        type: "half"
      }
    ]

    final_off_days = OffDayManager.create_off_days(person.id, new_off_days) |> IO.inspect()

    final_off_days
    |> Enum.each(fn off_day -> assert off_day.inserted_at != off_day.updated_at end)

    assert final_off_days == new_off_days
  end
end
