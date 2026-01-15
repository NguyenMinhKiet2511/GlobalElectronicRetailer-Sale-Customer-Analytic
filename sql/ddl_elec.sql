IF OBJECT_ID('elec.dim_customers', 'U') IS NOT NULL
    DROP TABLE elec.dim_customers;
GO

CREATE TABLE elec.dim_customers (
    customer_key INT PRIMARY KEY,
    gender NVARCHAR(10),
    name NVARCHAR(100),
    city NVARCHAR(50),
    state_code NVARCHAR(30),
    state NVARCHAR(50),
    zip_code NVARCHAR(10),
    country NVARCHAR(50),
    continent NVARCHAR(50),
    birthday DATETIME,
);


IF OBJECT_ID('elec.dim_products', 'U') IS NOT NULL
    DROP TABLE elec.dim_products;
GO

CREATE TABLE elec.dim_products (
    product_key INT PRIMARY KEY,
    product_name NVARCHAR(255),
    brand NVARCHAR(100),
    color NVARCHAR(50),
    unit_cost_usd  DECIMAL(10,2),
    unit_price_usd DECIMAL(10,2),
    subcategory_key INT,
    subcategory NVARCHAR(100),
    category_key INT,
    category NVARCHAR(100)
);


IF OBJECT_ID('elec.dim_stores', 'U') IS NOT NULL
    DROP TABLE elec.dim_stores;
GO

CREATE TABLE elec.dim_stores (
    store_key INT PRIMARY KEY,
    country NVARCHAR(100),
    state NVARCHAR(100),
    square_meters DECIMAL(10,2),
    open_date DATE
);

IF OBJECT_ID('elec.dim_exchange_rates', 'U') IS NOT NULL
    DROP TABLE elec.dim_exchange_rates;
GO

CREATE TABLE elec.dim_exchange_rates (
    date DATE,
    currency VARCHAR(10),
    exchange DECIMAL(10,6),

);

IF OBJECT_ID('elec.fact_sales', 'U') IS NOT NULL
    DROP TABLE elec.fact_sales;
GO

CREATE TABLE elec.fact_sales (
    order_number INT,
    line_item INT,
    order_date DATETIME,
    delivery_date DATETIME,
    customer_key INT,
    store_key INT,
    product_key INT,
    quantity INT,
    currency_code VARCHAR(10),

    FOREIGN KEY (customer_key) REFERENCES elec.dim_customers(customer_key),
    FOREIGN KEY (store_key) REFERENCES elec.dim_stores(store_key),
    FOREIGN KEY (product_key) REFERENCES elec.dim_products(product_key)
);