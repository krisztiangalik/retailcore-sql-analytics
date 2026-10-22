# 1. sum and average

numbers = [120, 80, 150, 90, 200]
total = sum(numbers)
average = sum(numbers) / len(numbers)
print(total)
print(average)

# 2. highest revenue store

sales = {"Store_A" : 1200, "Store_B" : 950, "Store_C" : 1430}
max_sale = max(sales, key=sales.get)
print(max_sale)
max_revenue = sales[max_sale]
print(max_revenue)

# 3. values above given value

values = [120, 80, 150, 90, 200]
for number in values:
    if number > 100:
        print(number)

# 4. Revenue function
def calculate_revenue(quantity, unit_price, discount):
    revenue = quantity * unit_price - discount
    return revenue
result = calculate_revenue(5, 1200, 500)
print(result)

# 5. Missing product IDs

product_ids = [101, 102, None, 104, None]
missing_count = 0
for product_id in product_ids:
    if product_id is None:
        missing_count += 1
print(missing_count)

