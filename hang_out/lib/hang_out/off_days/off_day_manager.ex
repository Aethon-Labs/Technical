defmodule HangOut.OffDays.OffDayManager do
  alias Ecto.Multi
  import Ecto.Query

  alias HangOut.OffDays.OffDay
  alias HangOut.Repo
  alias HangOut.People.PersonManager

  @doc """
    Every person has three off days: Two half, one whole.
    This function will receive the complete new schedule for a given person and update it.
  """
  def update_off_days(person_id, off_days) do
   #Challenge
    days = find_days(off_days)
    {:ok, person} = PersonManager.find_by({:id, person_id})
    person_changeset = Ecto.Changeset.change(PersonManager.load_off_days(person))
    person_with_days = Ecto.Changeset.put_assoc(person_changeset, :off_days, days)
    Repo.update!(person_with_days)
  end

  def find_days(off_days) do
    Enum.map(off_days, fn %{day: day, type: type} ->
      {:ok, off_day} = find_by({:day, day})
      OffDay.update_changeset(off_day, %{type: type})
    end)
  end

  def find_by({field, value}) do
    off_day =
      OffDay
      |> Repo.get_by([{field, value}])

    case off_day do
      nil -> {:error, "The day does not exist"}
      _ -> {:ok, off_day}
    end
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
