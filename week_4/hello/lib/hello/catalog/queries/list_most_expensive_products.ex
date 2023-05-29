defmodule Hello.Catalog.Queries.ListMostExpensiveProducts do
  def query() do
    Product
    |> order_by([product], product.price)
    |> limit(10)
  end
end
