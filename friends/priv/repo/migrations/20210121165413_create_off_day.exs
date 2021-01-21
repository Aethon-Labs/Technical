defmodule Friends.Repo.Migrations.CreateOffDay do
  use Ecto.Migration

  def change do
    create table(:off_days) do
      add(:day, :string, size: 3, null: false)
      add(:type, :string, size: 5, null: false)

      add(:person_id, references(:people, on_delete: :delete_all))

      timestamps()
    end

    create(
      unique_index(:off_days, [:person_id, :day], name: :single_off_day_per_day)
    )
  end
end
