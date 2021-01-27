defmodule HangOutWeb.Factory do

  use ExMachina.Ecto, repo: HangOut.Repo

  alias HangOut.People.Person
  alias HangOut.OffDays.OffDay

  def person_factory do
    %Person{
      first_name: "Jane Smith",
      last_name: "Smith",
      age: 20
    }
  end

  def off_day_factory do
    %OffDay{day: "Mon", type: "half", person: build(:person)}
  end
end
