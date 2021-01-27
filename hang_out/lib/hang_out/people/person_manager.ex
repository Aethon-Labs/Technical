defmodule HangOut.People.PersonManager do
  alias HangOut.People.Person
  alias HangOut.OffDays.OffDayManager
  alias HangOut.Repo

  @default_off_days [
    %{
      day: "fri",
      type: "half"
    },
    %{
      day: "sat",
      type: "whole"
    },
    %{
      day: "sun",
      type: "half"
    }
  ]

  def create_person(attrs \\ %{}) do
    person =
      %Person{}
      |> Person.changeset(attrs)
      |> Repo.insert()

    case person do
      {:ok, %Person{id: person_id} = person} ->
        OffDayManager.create_off_days(person_id, @default_off_days)
        {:ok, person}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def find_by({field, value}) do
    person =
      Person
      |> Repo.get_by([{field, value}])

    case person do
      nil -> {:error, "The day does not exist"}
      _ -> {:ok, person}
    end
  end

  def list_people(), do: Repo.all(Person)

  def load_off_days(person) do
    Repo.preload(person, :off_days, force: true)
  end
end
