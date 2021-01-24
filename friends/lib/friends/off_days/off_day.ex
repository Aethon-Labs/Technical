defmodule Friends.OffDays.OffDay do
  @moduledoc """
  Represents a day when a specific person is off work.
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Friends.People.Person

  @required_attrs ~w(person_id day type)a

  schema "off_days" do
    field(:hour, :string)
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
    |> validate_length(:hour, max: 3)
  end
end
