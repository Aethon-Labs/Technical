defmodule HangOutWeb.Resolvers.PersonResolver do
  alias HangOut.People.PersonManager

  def list_people(_parent, _args, _resolution) do
    {:ok, PersonManager.list_people()}
  end
end
