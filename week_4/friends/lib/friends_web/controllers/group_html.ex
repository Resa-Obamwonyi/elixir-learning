defmodule FriendsWeb.GroupHTML do
  use FriendsWeb, :html

  embed_templates "group_html/*"

  # renders a group form
  attr(:changeset, Ecto.Changeset, required: true)
  attr(:action, :string, required: true)

  def group_form(assigns)

end
