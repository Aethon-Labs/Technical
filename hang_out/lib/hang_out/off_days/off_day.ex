defmodule HangOut.OffDays.OffDay do
  @moduledoc """
  Represents a day when a specific person is off work.
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias HangOut.People.Person

  @required_attrs ~w(person_id day type)a

  schema "off_days" do
    field(:day, :string)
    field(:type, :string)

    belongs_to(:person, Person)

    timestamps(type: :utc_datetime)
  end

  def changeset(message, params) do
    # TODO: make sure only valid days and day types (half, whole) can be saved here
    # TODO: make sure there can only be one off day per day
    message
    |> cast(params, @required_attrs)
    |> validate_required(@required_attrs)
    |> validate_length(:type, max: 5)
    |> validate_length(:day, max: 3)
  end

  def update_changeset(off_day, params) do
    off_day
      |> cast(params, [:type])
  end
end
