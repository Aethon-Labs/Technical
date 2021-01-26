defmodule HangOutWeb.Schema do
  use Absinthe.Schema
  import_types(HangOutWeb.Schema.ContentTypes)

  alias HangOutWeb.Resolvers.PersonResolver

  query do
    @desc "Get all people"
    field :people, list_of(:person) do
      resolve(&PersonResolver.list_people/3)
    end
  end
end
