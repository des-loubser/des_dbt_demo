-- Converted from SSIS load_silver.dtsx: "Load SILVER_ORDERS"
-- FROM {{ source('bronze', 'BRONZE_ORDERS') }} o
{{ config(alias='SILVER_ORDERS') }}

SELECT
    o.order_id,
    o.customer_id,
    o.item,
    o.price,
    o.currency,
    o.date AS au_date,
    -- T-SQL "AT TIME ZONE 'UTC'" on a DATETIME2 labels the value as UTC without shifting it
    TIMESTAMP(o.date, 'UTC') AS utc_date,
    o.audit_modified_date,
    o.audit_current
FROM {{ ref('bronze_orders') }} o

