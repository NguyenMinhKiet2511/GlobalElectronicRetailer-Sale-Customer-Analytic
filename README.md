# Global Electronics Retail Performance (2016–2021)

End-to-end data analytics project for a global electronics retailer, covering **data cleaning (Python)** → **data modeling (SQL)** → **interactive dashboards (Tableau)**.

**Tableau Public (interactive dashboards):**
- https://public.tableau.com/app/profile/nguyen.kiet1348/viz/ElectronicSalesCustomerPerfomance/CustomerDB?publish=yes

> **Time coverage:** 2016–2021 (2021 data available through **2021-02-20**).  
> **Period framework:** **Matched YTD (CY vs PY)** for fair YoY comparisons.  
> **New customer definition:** *first observed purchase in the dataset within the matched period*.

---

## 1. Dataset

This project uses a retail dataset with **62,885 sales records** and **five tables**:
- `customers`
- `stores`
- `sales`
- `products`
- `exchange_rates`

### ER Diagram

![ER Diagram](GlobalElectronic.drawio.png)

---

## 2. Business Questions

### Sales performance
- How are **Revenue, Gross Profit, Gross Margin, Orders, and AOV** trending YoY?
- Which **countries / categories / products** contribute most to performance changes?
- Are we growing through **volume** (orders) or **basket size** (AOV)?

### Customer health
- Are we growing via **acquisition** (new customers) or **retention** (returning customers)?
- How healthy is the customer base based on **recency buckets**?
- Which **VIP customers** are most valuable and potentially at-risk?

---

## 3. Key Definitions (important for interpretation)

### Matched YTD (CY vs PY)
To avoid misleading YoY comparisons when the current year is incomplete, the dashboards use a **Matched Year-to-Date** window:
- **CY (Current Year):** from `CY Start` to `CY End`
- **PY (Previous Year matched):** same length window in the previous year

This ensures CY and PY represent comparable periods.

### New Customer (dataset-based)
**New customer** is defined as:
> *first observed purchase in the dataset within the matched period*

This is **not** “first-ever purchase outside the dataset”.

---

## 4. Data Pipeline Overview

### Step 1 — Python cleaning (Pandas)
Notebook: `python/elec_data_cleaning.ipynb`

Typical steps include:
- Standardize column names to `snake_case`
- Convert datatypes (e.g., `birthday` to datetime)
- Handle missing values (e.g., `state_code` filled with `UNKNOWN`)
- Basic data profiling (nulls, duplicates)

### Step 2 — SQL modeling & loading
DDL: `sql/ddl_elec.sql`  
Load script: `sql/load_elec.sql`

A star schema is created under the `elec` schema:
- `elec.dim_customers`
- `elec.dim_products`
- `elec.dim_stores`
- `elec.dim_exchange_rates`
- `elec.fact_sales`

### Step 3 — Analytical dataset for Tableau
Query: `sql/sales&customer_query.sql`

This query joins `fact_sales` with dimensions and derives analytical fields such as:
- `revenue = quantity * unit_price_usd`
- `total_cost = quantity * unit_cost_usd`
- `profit = revenue - total_cost`

---

## 5. Dashboards (Tableau)

The Tableau workbook contains two tabs:
1. **Sales Dashboard**
2. **Customer Dashboard**

### Sales Dashboard KPIs
- Revenue
- Gross Profit
- Gross Margin (% and pp change YoY)
- Orders
- AOV (Average Order Value)

### Customer Dashboard KPIs
- Active Customers
- New Customers
- % New Customers (pp change YoY)
- Orders per Customer
- Profit per Customer

> 2021 is partial-year (through 2021-02-20), and the dashboards use **Matched YTD** to keep comparisons consistent.

---

## 6. Multi-year Findings (2016–2021)

### Growth period (2016–2019)
- Revenue increased from **$6.95M (2016)** to **$18.26M (2019)**.
- Gross margin remained stable around **~58–59%**, indicating consistent unit economics.

### 2020 demand shock
- Revenue and Orders dropped by ~**49% YoY**, while **AOV and Gross Margin stayed nearly flat**.
- This suggests the downturn was driven primarily by **volume / demand** rather than pricing or margin erosion.

### Customer acquisition & retention shift (2020)
- New customers fell sharply (e.g., **-66.6% YoY** in 2020).
- Customer engagement and value declined (lower orders per customer and profit per customer).

---

## 7. Recommendations

1. **Win-back / reactivation campaigns**  
   Target customers in high-recency buckets (e.g., 91–180 and 180+ days) and track reactivation rate, repeat orders, and profit per customer.

2. **Rebuild acquisition where unit economics are strong**  
   Prioritize categories/countries with margin at/above overall benchmark and monitor new customers and order volume.

3. **Protect margin; avoid broad discounting**  
   Because gross margin stayed stable even in downturn, focus on bundles/upsell rather than aggressive price cuts.

4. **VIP at-risk outreach**  
   Identify high-profit customers with poor recency and run targeted retention actions.

---

## 8. Repository Structure

- `datasets/` — raw/cleaned datasets (if included)
- `python/` — data cleaning notebook(s)
- `sql/` — schema, load scripts, analytical query
- `tableau/` — Tableau workbook/assets (if included)

---

## 9. Notes / Limitations

- 2021 data is available only through **2021-02-20**; analysis uses **Matched YTD** to avoid biased YoY comparisons.
- “New customer” is defined as **first observed purchase in the dataset**, which may differ from “first-ever” in the real world.

---

## 10. Author

**NguyenMinhKiet2511**
