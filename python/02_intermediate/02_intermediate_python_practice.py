# 1. list comprehension: create a list with the values above 1000.

sales = [1200, 950, 1430, 800, 2100]
high_sales =[]
for sale in sales:
    if sale > 1000:
        high_sales.append(sale)
print(high_sales)

## or:

high_sales = [sale for sale in sales if sale > 1000]
print(high_sales)

# 2. Create a new dictionary with the revenue above 1000.

store_sales = {
    "Store_A" : 1200,
    "Store_B" : 950,
    "Store_C" : 1430,
    "Store_D" : 800
}
high_sales = {}
for store, revenue in store_sales.items():
    if revenue > 1000:
        high_sales[store] = revenue
print(high_sales)

## or:

high_sales = {
    store: revenue
    for store, revenue in store_sales.items()
    if revenue > 1000
}
print(high_sales)

# 3. Create a new list, which:
# - skip the None values,
# - contain only the values above 1000

sales = [1200, 950, None, 1430, 800, None, 2100]
cleaned_sales_list = [
    item
    for item in sales
        if item is not None and item > 1000
]
print(cleaned_sales_list)

# 4. Write a formula which calculate the revenue, but not crash when there is an invalid value in the list.

def calculate_revenue(quantity, unit_price, discount):
    try:
        revenue = quantity * unit_price - discount
        return revenue
    except TypeError:
        return None
print(calculate_revenue(5, 1200, 500))
print(calculate_revenue(None, 1200, 500))

## improving the code:

def calculate_revenue(quantity, unit_price, discount):
    try:
        revenue = quantity * unit_price - discount
        return revenue
    except TypeError as error:
        print("Wrong data:", error)
        return None
print(calculate_revenue(5, 1200, 500))
print(calculate_revenue(None, 1200, 500))

# 5. Calculate the revenue in a new list and skip the invalid values in the new list.

sales = [
    {"store": "Store_A", "quantity": 5, "unit_price": 1200, "discount": 500},
    {"store": "Store_B", "quantity": None, "unit_price": 900, "discount": 0},
    {"store": "Store_C", "quantity": 3, "unit_price": 1500, "discount": 200},
    {"store": "Store_D", "quantity": 2, "unit_price": None, "discount": 100}
]
clean_revenue = []
for sale in sales:
    try:
        revenue = (
            sale["quantity"] * sale["unit_price"] - sale["discount"]
        )
        sale["revenue"] = revenue
        clean_revenue.append(sale)
    except TypeError:
        print("Hibás rekord:", sale)
print(clean_revenue)

# 6. Separate the above results into two different list: clean_revenue and invalid_revenue

sales = [
    {"store": "Store_A", "quantity": 5, "unit_price": 1200, "discount": 500},
    {"store": "Store_B", "quantity": None, "unit_price": 900, "discount": 0},
    {"store": "Store_C", "quantity": 3, "unit_price": 1500, "discount": 200},
    {"store": "Store_D", "quantity": 2, "unit_price": None, "discount": 100}
]
clean_revenue = []
invalid_revenue = []
for sale in sales:
    try:
        revenue = (
            sale["quantity"] * sale["unit_price"] - sale["discount"]
        )
        sale["revenue"] = revenue
        clean_revenue.append(sale)
    except TypeError:
        invalid_revenue.append(sale)
print("Clean_revenue:", clean_revenue)
print("Invalid_revenue:", invalid_revenue)

# 7. sorted() + key=

stores = [
    {"store": "Store_A", "revenue": 1200},
    {"store": "Store_B", "revenue": 950},
    {"store": "Store_C", "revenue": 1430},
    {"store": "Store_D", "revenue": 800}
]
sorted_stores = sorted(
    stores,
    key = lambda store: store["revenue"], reverse = False
)
print(sorted_stores)

# 8. importing and using moduls

import math
number = 25
result = math.sqrt(number)
print(result)

revenue = 1450.75
result_one = math.ceil(revenue)
result_two = math.floor(revenue)

print(result_one, result_two)

# or:

from math import ceil, floor
revenue= 1450.75
rounded_up = ceil(revenue)
rounded_down = floor(revenue)
print(rounded_up, rounded_down)

## 8.1

import pandas as pd
data = {
    "store": ["Store_A", "Store_B"],
    "revenue": [1200, 950]
}
df = pd.DataFrame(data)
print(df)

## 9. position and keyword arguments

def calculate_total(price, quantity, discount=0):
    return price * quantity - discount
print(calculate_total(1500, 4, 300))
print(calculate_total(quantity=4, price=1500, discount=300))

## 10. *args

def calculate_revenue(*revenues):
    return sum(revenues)
print(calculate_revenue(1200,950,1430))

def print_sale_details(**details):
    for key, value in details.items():
        print(key, value)
print_sale_details(store="Store_B",
                   product="Product_12",
                   quantity=3,
                   revenue=4200)

## 11. docstring

def calculate_total(price, quantity, discount=0):
    """Calculate the total revenue.
    
    Parameters: 
        price: Price of the product
        quantity: Quantity of the products
        discount: Discount amount from the price
        
    Returns: Calculated revenue
    
    """
    return price * quantity - discount

## 12. lambda

numbers = [2, 4, 6, 8]
square = lambda number: number ** 2
print(square(5))

square_numbers = list(
    map(lambda number: number ** 2, numbers)
)
print(square_numbers)

revenues = [1200, 950, 1430, 800]
ten_percent_list = list(
    map(lambda revenue: revenue * 1.1, revenues)
)
print(ten_percent_list)

## 13. filter + lambda

revenues = [1200, 950, 1430, 800, 2100]
high_revenues = list(
    filter(lambda revenue: revenue > 1000, revenues)
)
print(high_revenues)

revenues = [1200, None, 950, 1430, None, 800]
non_none_values = list(
    filter(lambda value: value is not None, revenues)
)
print(non_none_values)

## 14. Errors

sales = [
    {"store": "Store_A", "revenue": "1200"},
    {"store": "Store_B", "revenue": "N/A"},
    {"store": "Store_C"}
]
for sale in sales:
    try:
        revenue = int(sale["revenue"])
        print(sale["store"], revenue)
    except ValueError:
        print("Wrong revenue value:", sale)
    except KeyError:
        print("Missing key:", sale)

sales = [
    {"store": "Store_A", "revenue": "1200"},
    {"store": "Store_B", "revenue": "N/A"},
    {"store": "Store_C"}
]

invalid_sales = []

for sale in sales:
    try:
        revenue = int(sale["revenue"])
        print(sale["store"], revenue)
    except ValueError:
        invalid_sales.append(sale)
    except KeyError:
        invalid_sales.append(sale)
print("Invalid sales: ", invalid_sales)

## 15. pandas

import pandas as pd

sales = {
    "store": ["Store_A", "Store_B", "Store_C"],
    "revenue": [1200, 950, 1430]
}

df = pd.DataFrame(sales)

print(df)

#########

import pandas as pd
df = pd.read_csv("python/02_intermediate/02_sample_sales.csv")

print(df)
print(df.head())
print(df.shape)
print(df.dtypes)

##########
print(df["revenue"])

high_revenue = df[df["revenue"] > 1000]
print(high_revenue)
print(df["revenue"].sum())
print(df["revenue"].mean())
print(df["revenue"].max())

filtered_df = df[df["quantity"] >= 5]
result = filtered_df[["store", "revenue"]]
print(result)

df["high_revenue"] = (df["revenue"]>1000)
print(df)

############

import pandas as pd

sales = {
    "store": ["Store_A", "Store_A", "Store_B", "Store_B", "Store_C"],
    "revenue": [1200, 800, 950, 1100, 1430],
    "quantity": [5, 3, 4, 6, 7]
}

df = pd.DataFrame(sales)


summary = df.groupby("store").agg(
    total_revenue = ("revenue", "sum"),
    total_quantity = ("quantity", "sum")
).reset_index()
sorted_summary = summary.sort_values(
    "total_revenue",
    ascending=False
)
print(sorted_summary)

############

import pandas as pd

sales = {
    "store": ["Store_A", "Store_B", "Store_C", "Store_D"],
    "revenue": [1200, None, 1430, 800],
    "quantity": [5, 3, None, 2]
}

df = pd.DataFrame(sales)

print(df)
print(df.isna())
print(df.isna().sum())

# 16. strings

import string
store_codes = [
    "STORE01",
    "STORE02",
    "STORE_03",
    "STORE04!",
    "store05"
]
allowed_characters = string.ascii_uppercase + string.digits
for code in store_codes:
    if all(character in allowed_characters for character in code):
        print(code)