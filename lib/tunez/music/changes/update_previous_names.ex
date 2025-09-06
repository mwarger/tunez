defmodule Tunez.Music.Changes.UpdatePreviousNames do
  use Ash.Resource.Change

  @impl true
  def change(changeset, _opts, _ctx) do
    # after-change
    new_name = Ash.Changeset.get_attribute(changeset, :name)
    # before-change
    old_name = changeset.data.name
    prev = changeset.data.previous_names || []

    names =
      [old_name | prev]
      |> Enum.reject(&is_nil/1)
      |> Enum.uniq()
      |> Enum.reject(&(&1 == new_name))

    Ash.Changeset.change_attribute(changeset, :previous_names, names)
  end
end
