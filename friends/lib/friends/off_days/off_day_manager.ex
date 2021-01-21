defmodule Friends.OffDays.OffDayManager do
  alias Ecto.Multi
  import Ecto.Query

  alias Friends.OffDays.OffDay
  alias Friends.Repo

  def set_off_days(person_id, off_days) do
    # TODO: Get this working
    off_days
    |> Enum.map(&Map.put(&1, :person_id, person_id))
    |> Enum.map(&OffDay.changeset(%OffDay{}, &1))
    |> Enum.reduce(Multi.new(), &Multi.update(&2, {:off_day, &1}, &1, on_conflict: :nothing))
    |> Repo.transaction()

    get_off_days(person_id)
  end

  def get_off_days(person_id) do
    from(off_day in OffDay, where: off_day.person_id == ^person_id)
    |> Repo.all()
  end
end
