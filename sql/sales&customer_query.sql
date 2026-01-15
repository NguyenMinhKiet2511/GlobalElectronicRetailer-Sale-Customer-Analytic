SELECT 
    c.customer_key,
    c.gender,
    c.name,
    c.city,
    c.state,
    c.country,
    c.continent,
    c.birthday,
    DATEDIFF(year,c.birthday,GETDATE()) AS age,
    CASE
        WHEN DATEDIFF(year,c.birthday,GETDATE()) < 25 THEN 'Under 25'
        WHEN DATEDIFF(year,c.birthday,GETDATE()) BETWEEN 25 AND 34 THEN '25–34'
        WHEN DATEDIFF(year,c.birthday,GETDATE()) BETWEEN 35 AND 44 THEN '35–44'
        WHEN DATEDIFF(year,c.birthday,GETDATE()) BETWEEN 45 AND 54 THEN '45–54'
        ELSE '55+'
    END AS age_group,
    CASE WHEN EXISTS (
        SELECT 1
        FROM elec.fact_sales s2
		WHERE s2.customer_key = s.customer_key 
              AND year(s2.order_date) < year(s.order_date)
        ) THEN 'Repeat'
        ELSE 'New'
    END AS customer_status, 
    COUNT(c.customer_key) OVER (PARTITION BY c.customer_key) AS order_count,

    s.order_number,
    s.order_date,
    s.line_item,
    s.quantity,

    st.store_key,
    st.country AS store_country,
    st.state AS store_state, 
    st.square_meters,
    st.open_date,

    p.product_key,
    REPLACE(p.product_name,'"','') AS product_name,
    p.brand,
    p.color,
    p.unit_cost_usd,
    p.unit_price_usd,
    s.quantity * p.unit_price_usd AS revenue,
    s.quantity * p.unit_cost_usd AS totaL_cost,
    (s.quantity * p.unit_price_usd) - (s.quantity * p.unit_cost_usd) AS profit,
    p.subcategory,
    REPLACE(p.category,'"','') AS category

FROM elec.fact_sales s
JOIN elec.dim_customers c
ON  c.customer_key = s.customer_key
JOIN elec.dim_stores st 
ON st.store_key = s.store_key
JOIN elec.dim_products p 
ON p.product_key = s.product_key