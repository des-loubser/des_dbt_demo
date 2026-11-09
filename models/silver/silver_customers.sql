-- Converted from SSIS load_silver.dtsx: "Load SILVER_CUSTOMERS"
-- NOTE: the original SSIS source query was a copy of the orders query (read BRONZE_ORDERS).
-- Rewritten to read BRONZE_CUSTOMERS with the columns of the SILVER_CUSTOMERS DDL.


{{ config(alias='SILVER_CUSTOMERS') }}

SELECT
    c.customer_id,
    c.name,
    c.age,
    c.audit_modified_date,
    c.audit_current
FROM {{ ref('bronze_customers') }} c
