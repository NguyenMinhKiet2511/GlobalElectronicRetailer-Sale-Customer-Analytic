TRUNCATE TABLE elec.dim_customers

BULK INSERT elec.dim_customers
FROM 'C:\data\cleaned_elec\cleaned_customers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

TRUNCATE TABLE elec.dim_products    

BULK INSERT elec.dim_products
FROM 'C:\data\cleaned_elec\cleaned_products.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

TRUNCATE TABLE elec.dim_stores   

BULK INSERT elec.dim_stores
FROM 'C:\data\cleaned_elec\cleaned_stores.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

TRUNCATE TABLE elec.dim_exchange_rates 

BULK INSERT elec.dim_exchange_rates
FROM 'C:\data\cleaned_elec\cleaned_exr.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

TRUNCATE TABLE elec.fact_sales

BULK INSERT elec.fact_sales
FROM 'C:\data\cleaned_elec\cleaned_sales.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

