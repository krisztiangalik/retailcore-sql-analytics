sales = [
    {"store": "Store_A", "revenue": "1200", "quantity": 5},
    {"store": "Store_B", "revenue": "N/A", "quantity": 3},
    {"store": "Store_C", "revenue": "1430", "quantity": 7},
    {"store": "Store_D", "quantity": 2},
    {"store": "Store_E", "revenue": "800", "quantity": 4}
]

#Create a program that:
#- creates a clean_sales list and an invalid_sales list
#- loops through all sales records
#- converts the revenue value to an integer
#- adds records with a ValueError or KeyError to the invalid_sales list
#- adds a new field called revenue_per_unit to valid records
#- calculates revenue_per_unit as revenue / quantity
#- adds valid records to the clean_sales list
#- sorts clean_sales by revenue in descending order using sorted() and lambda
#- prints both the clean and invalid sales records at the end

clean_sales = []
invalid_sales = []

for sale in sales:
    try:
        revenue = int(sale["revenue"])
        sale["revenue"] = revenue

        revenue_per_unit = revenue / sale["quantity"]

        sale["revenue_per_unit"] = revenue_per_unit
        clean_sales.append(sale)
    except (ValueError, KeyError):
        invalid_sales.append(sale)
sorted_clean_sales = sorted(
    clean_sales,
    key=lambda sale: sale["revenue"],
    reverse=True
)
print("Clean sales:")
print(sorted_clean_sales)

print("Invalid sales:")
print(invalid_sales)
