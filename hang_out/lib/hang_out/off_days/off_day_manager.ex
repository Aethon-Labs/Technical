defmodule HangOut.OffDays.OffDayManager do
  alias Ecto.Multi
  import Ecto.Query

  alias HangOut.OffDays.OffDay
  alias HangOut.Repo

  @doc """
    Every person has three off days: Two half, one whole.
    This function will receive the complete new schedule for a given person and update it.
  """
  def update_off_days(person_id, off_days) do
    # TECHNICAL-TODO: Get this working. See the test here: `hang_out/test/hang_out/off_days/off_day_manager_test.exs`
    off_days
    |> Enum.map(&Map.put(&1, :person_id, person_id))
    |> Enum.map(&OffDay.changeset(%OffDay{}, &1))
    # |> Enum.reduce(Multi.new(), &Multi.update())
    |> Repo.transaction()

    {:ok, get_off_days(person_id)}
  end

  def create_off_days(person_id, off_days) do
    off_days
    |> Enum.map(&Map.put(&1, :person_id, person_id))
    |> Enum.map(&OffDay.changeset(%OffDay{}, &1))
    |> Enum.reduce(Multi.new(), &Multi.insert(&2, {:off_day, &1}, &1, on_conflict: :nothing))
    |> Repo.transaction()
    |> IO.inspect()

    {:ok, get_off_days(person_id)}
  end

  def get_off_days(person_id) do
    from(off_day in OffDay, where: off_day.person_id == ^person_id)
    |> Repo.all()
  end
end
