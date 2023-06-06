defmodule FriendsWeb.GroupHTML do
  use FriendsWeb, :html
  import Phoenix.HTML.Form


  embed_templates "group_html/*"

  # renders a group form
  attr(:changeset, Ecto.Changeset, required: true)
  attr(:action, :string, required: true)

  def group_form(assigns)

  attr(:address, Friends.Collection.Group.Address, required: true)
  def address(assigns) do
    ~H"""
      <div>
      <%= @address.street_number %> <%= @address.street_name %>, <%= @address.city %>, <%= @address.country %>
      </div>
    """
  end

end
