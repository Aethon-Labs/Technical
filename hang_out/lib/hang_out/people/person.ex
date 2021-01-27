defmodule HangOut.People.Person do
  use Ecto.Schema
  alias HangOut.OffDays.OffDay

  schema "people" do
    field :first_name, :string
    field :last_name, :string
    field :age, :integer
    has_many :off_days, OffDay
  end

  def changeset(person, params \\ %{}) do
    person
    |> Ecto.Changeset.cast(params, [:first_name, :last_name, :age])
    |> Ecto.Changeset.validate_required([:first_name, :last_name])
  end

end
