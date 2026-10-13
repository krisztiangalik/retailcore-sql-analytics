INSERT INTO stores (
    store_id,
    store_name,
    store_address,
    city,
    country
)
VALUES
    (1, 'RetailCore Central', '12 Main Street', 'Budapest', 'Hungary'),
    (2, 'RetailCore North', '45 Market Road', 'Debrecen', 'Hungary'),
    (3, 'RetailCore East', '8 Commerce Avenue', 'Nyiregyhaza', 'Hungary'),
    (4, 'RetailCore West', '77 Business Street', 'Gyor', 'Hungary'),
    (5, 'RetailCore South', '31 Retail Park', 'Szeged', 'Hungary');

INSERT INTO categories (
    category_id,
    category_name
)
VALUES
    (1, 'Dairy'),
    (2, 'Bakery'),
    (3, 'Meat'),
    (4, 'Fruit'),
    (5, 'Vegetables'),
    (6, 'Beverages'),
    (7, 'Frozen Food'),
    (8, 'Household'),
    (9, 'Personal Care'),
    (10, 'Snacks');

INSERT INTO suppliers (
    supplier_id,
    supplier_name,
    supplier_address,
    supplier_telephone,
    supplier_email
)
VALUES
    (1, 'FreshFarm Foods', '10 Farm Road, Budapest', '+3615550101', 'contact@freshfarm.hu'),
    (2, 'Danube Dairy', '22 Milk Street, Gyor', '+36965550102', 'sales@danubedairy.hu'),
    (3, 'Golden Bakery Supply', '18 Baker Lane, Budapest', '+3615550103', 'orders@goldenbakery.hu'),
    (4, 'Prime Meat Distribution', '54 Industrial Road, Debrecen', '+36525550104', 'sales@primemeat.hu'),
    (5, 'GreenField Produce', '9 Orchard Street, Nyiregyhaza', '+36425550105', 'office@greenfield.hu'),
    (6, 'Aqua Drinks', '41 River Road, Budapest', '+3615550106', 'orders@aquadrinks.hu'),
    (7, 'FrozenWorld', '62 Cold Storage Park, Gyor', '+36965550107', 'info@frozenworld.hu'),
    (8, 'HomeCare Wholesale', '11 Warehouse Street, Szeged', '+36625550108', 'sales@homecare.hu'),
    (9, 'PureLife Products', '27 Wellness Avenue, Budapest', '+3615550109', 'contact@purelife.hu'),
    (10, 'SnackPoint Distribution', '80 Logistics Road, Debrecen', '+36525550110', 'orders@snackpoint.hu');

INSERT INTO employees (
    employee_id,
    employee_name,
    employee_email,
    store_id,
    job_title
)
VALUES
    (1, 'Anna Kovacs', 'anna.kovacs@retailcore.hu', 1, 'Store Manager'),
    (2, 'Peter Nagy', 'peter.nagy@retailcore.hu', 1, 'Cashier'),
    (3, 'Dora Toth', 'dora.toth@retailcore.hu', 1, 'Cashier'),
    (4, 'Gabor Horvath', 'gabor.horvath@retailcore.hu', 2, 'Store Manager'),
    (5, 'Reka Varga', 'reka.varga@retailcore.hu', 2, 'Cashier'),
    (6, 'Adam Kiss', 'adam.kiss@retailcore.hu', 3, 'Store Manager'),
    (7, 'Nora Farkas', 'nora.farkas@retailcore.hu', 3, 'Cashier'),
    (8, 'Balazs Molnar', 'balazs.molnar@retailcore.hu', 4, 'Store Manager'),
    (9, 'Eszter Szabo', 'eszter.szabo@retailcore.hu', 4, 'Cashier'),
    (10, 'Mate Lakatos', 'mate.lakatos@retailcore.hu', 5, 'Store Manager'),
    (11, 'Lilla Papp', 'lilla.papp@retailcore.hu', 5, 'Cashier'),
    (12, 'Daniel Simon', 'daniel.simon@retailcore.hu', 3, 'Cashier');

INSERT INTO customers (
    customer_id,
    customer_name,
    zipcode,
    registration_date
)
VALUES
    (1, 'Mark Smith', '1011', '2025-01-10'),
    (2, 'Julia Brown', '1024', '2025-01-22'),
    (3, 'David Wilson', '4025', '2025-02-03'),
    (4, 'Emma Taylor', '4400', '2025-02-15'),
    (5, 'Daniel Johnson', '9021', '2025-03-01'),
    (6, 'Sophia Miller', '6720', '2025-03-08'),
    (7, 'Oliver Davis', '1033', '2025-03-18'),
    (8, 'Mia Anderson', '4032', '2025-04-01'),
    (9, 'Lucas Thomas', '4405', '2025-04-14'),
    (10, 'Emily Moore', '9024', '2025-04-29'),
    (11, 'Benjamin Martin', '6724', '2025-05-05'),
    (12, 'Charlotte Lee', '1117', '2025-05-19'),
    (13, 'Henry Walker', '4026', '2025-06-02'),
    (14, 'Amelia Hall', '4400', '2025-06-17'),
    (15, 'Jack Allen', '9028', '2025-07-01'),
    (16, 'Ella Young', '6726', '2025-07-13'),
    (17, 'Samuel King', '1138', '2025-08-02'),
    (18, 'Grace Wright', '4031', '2025-08-16'),
    (19, 'Leo Scott', '4405', '2025-09-04'),
    (20, 'Chloe Green', '6722', '2025-09-20');

INSERT INTO products (
    product_id,
    category_id,
    product_name,
    current_price,
    supplier_id
)
VALUES
    (1, 1, 'Whole Milk 1L', 449.00, 2),
    (2, 1, 'Greek Yogurt', 599.00, 2),
    (3, 1, 'Butter 250g', 999.00, 2),
    (4, 2, 'White Bread', 549.00, 3),
    (5, 2, 'Wholegrain Bread', 699.00, 3),
    (6, 2, 'Croissant', 399.00, 3),
    (7, 3, 'Chicken Breast 1kg', 2499.00, 4),
    (8, 3, 'Pork Loin 1kg', 2199.00, 4),
    (9, 3, 'Ground Beef 500g', 1899.00, 4),
    (10, 4, 'Apple 1kg', 699.00, 5),
    (11, 4, 'Banana 1kg', 749.00, 5),
    (12, 4, 'Orange 1kg', 899.00, 5),
    (13, 5, 'Tomato 1kg', 1099.00, 5),
    (14, 5, 'Potato 2kg', 1199.00, 5),
    (15, 5, 'Carrot 1kg', 649.00, 5),
    (16, 6, 'Mineral Water 1.5L', 199.00, 6),
    (17, 6, 'Orange Juice 1L', 799.00, 6),
    (18, 6, 'Cola 1.5L', 699.00, 6),
    (19, 7, 'Frozen Pizza', 1599.00, 7),
    (20, 7, 'Frozen Vegetables 1kg', 1299.00, 7),
    (21, 7, 'Ice Cream 1L', 1799.00, 7),
    (22, 8, 'Laundry Detergent', 3499.00, 8),
    (23, 8, 'Dishwashing Liquid', 899.00, 8),
    (24, 8, 'Paper Towels', 1299.00, 8),
    (25, 9, 'Shampoo', 1499.00, 9),
    (26, 9, 'Toothpaste', 899.00, 9),
    (27, 9, 'Shower Gel', 1199.00, 9),
    (28, 10, 'Potato Chips', 799.00, 10),
    (29, 10, 'Chocolate Bar', 499.00, 10),
    (30, 10, 'Mixed Nuts', 1399.00, 10);