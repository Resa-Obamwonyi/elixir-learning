# [
  # %{id: 1, name: "Test", revenue: 3_000_000, year: 2019},
  # %{id: 1, name: "Test", revenue: 2_600_000, year: 2020},
  # %{id: 1, name: "Test", revenue: 1_200_000, year: 2021},
  # %{id: 2, name: "Test2", revenue: 3_000_000, year: 2019},
  # %{id: 2, name: "Test2", revenue: 2_000_000, year: 2020},
  # %{id: 2, name: "Test2", revenue: 4_000_000, year: 2021},
# ]

items = get_company_revenues_per_year() # %{id: company.id, name: company.name, revenue: company.revenue, company.year}
result1 = Enum.group_by(items, fn company -> company.id
    end)

Enum.map(result1, fn {id, company_entries_per_year} ->
first_entry = List.first(company_entries_per_year)
revenues = Enum.map(company_entries_per_year, fn item -> item.revenue end))
%{id: id, name: first_entry.name, revenue: Enum.sum(revenues)}
end)

# %{
      # 1: [
      #   %{id: 1, name: "Test", revenue: 3_000_000, year: 2019},
      #   %{id: 1, name: "Test", revenue: 2_600_000, year: 2020},
      #   %{id: 1, name: "Test", revenue: 1_200_000, year: 2021}
      # ]

      # 2: [
      #   %{id: 2, name: "Test2", revenue: 3_000_000, year: 2019},
      #   %{id: 2, name: "Test2", revenue: 2_000_000, year: 2020},
      #   %{id: 2, name: "Test2", revenue: 4_000_000, year: 2021},
      # ]
#}


# [
# %{id: 1, name: "Test", revenue: 6_800_000},
# %{id: 2, name: "Test2", revenue: 9_000_000},
# ]

get_company_revenues_per_year() # %{id: company.id, name: company.name, revenue: company.revenue, company.year}

|> Enum.group_by(fn company ->
    company.id end)

|> Enum.map(fn {id, company_entries_per_year} ->
first_entry = List.first(company_entries_per_year)

revenues = Enum.map(company_entries_per_year, fn item -> item.revenue end))
    %{id: id, name: first_entry.name, revenue: Enum.sum(revenues)}
end)


get_company_revenues_per_year() # %{id: company.id, name: company.name, revenue: company.revenue, company.year}

|> Enum.group_by(& &1.id) # equal!

|> Enum.group_by(&my_function/1) # equal!

|> Enum.group_by(&my_function(&1)) # equal!

|> Enum.group_by(fn item -> item.id end)

|> Enum.map(fn {id, company_entries_per_year} ->

first_entry = List.first(company_entries_per_year)

revenues = Enum.map(company_entries_per_year, fn item -> item.revenue end))
    %{id: id, name: first_entry.name, revenue: Enum.sum(revenues)}
end)

def my_function(company) do
  company.id
end


# the same call, but with different syntax for keyword lists

IO.inspect([99, 97, 116], charlists: :as_list, pretty: true)

IO.inspect([99, 97, 116], [charlists: :as_list, pretty: true])

IO.inspect([99, 97, 116], [{:charlists, :as_list}, {:pretty, true}])
