CREATE TABLE stores (
    store_id INTEGER PRIMARY KEY,
    store_name VARCHAR (100) NOT NULL,
    sotre_address VARCHAR (200),
    city VARCHAR (100),
    country VARCHAR (100) NOT NULL
);

CREATE TABLE employees(
    employee_id INTEGER PRIMARY KEY,
    employee_name VARCHAR (100) NOT NULL,
    employee_email VARCHAR (200) UNIQUE,
    store_id INTEGER NOT NULL,
    job_title VARCHAR (100) NOT NULL,
    FOREIGN KEY (store_id)
        REFERENCES stores(store_id)
);

CREATE TABLE customers(
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR (200) NOT NULL,
    zipcode VARCHAR (20) NOT NULL,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE categories(
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR (100) NOT NULL
);

CREATE TABLE suppliers(
    supplier_id INTEGER PRIMARY KEY,
    supplier_name VARCHAR (200) NOT NULL,
    supplier_address VARCHAR (200) NOT NULL,
    supplier_telephone VARCHAR (20),
    supplier_email VARCHAR(200) UNIQUE
);

CREATE TABLE products(
    product_id INTEGER PRIMARY KEY,
    category_id INTEGER NOT NULL,
    product_name VARCHAR (100) NOT NULL,
    current_price DECIMAL (10,2) NOT NULL CHECK (current_price >=0),
    supplier_id INTEGER NOT NULL,
    FOREIGN KEY(category_id)
        REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id)
);

CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY,
    store_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    sale_datetime TIMESTAMP,
    FOREIGN KEY (store_id)
        REFERENCES stores(store_id),
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE sales_items(
    sale_item_id INTEGER PRIMARY KEY,
    sale_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity DECIMAL (10,3) NOT NULL CHECK (quantity>=0),
    unit_price DECIMAL (10,2) NOT NULL CHECK (unit_price >=0),
    discount_amount DECIMAL (10,2) NOT NULL CHECK (discount_amount>=0),
    FOREIGN KEY (sale_id)
        REFERENCES sales(sale_id),
    FOREIGN KEY (product_id)
        REFERENCES produts(product_id)
);