defmodule HelloWeb.ProductHTML do
  use HelloWeb, :html

  embed_templates("product_html/*")

  @doc """
  Renders a product form.
  """
  attr(:changeset, Ecto.Changeset, required: true)
  attr(:action, :string, required: true)

  def product_form(assigns)

  attr(:product, :map, required: true)

  def product_overview(assigns) do
    ~H"""
    <div class="bg-yellow-200 box-border h-320 w-320 p-4 border-4 ">

      <h1 class="text-4xl font-medium text-red-600"><%= @product.title %></h1>
      <p class="text-1xl font-medium text-yellow-700"><%= @product.description %></p>

      <div class="flex justify-between">
        <span>$<%= @product.price %></span>
        <button class="rounded-lg bg-green-900 py-1 px-40 text-sm font-semibold leading-6 text-white">
        BUY
        </button>
      </div>

    </div>
    """
  end
end
