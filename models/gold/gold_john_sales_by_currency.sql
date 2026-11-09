-- Converted from SSIS load_gold.dtsx -> sales.sp_load_GOLD_JOHN_SALES_BY_REGION
{{ config(alias='GOLD_JOHN_SALES_BY_CURRENCY') }}

WITH johns AS (
    SELECT *
    FROM {{ ref('silver_customers') }}
    WHERE CAST(audit_current AS BOOL) = TRUE
      AND name LIKE '%John%'
),

john_orders AS (
    SELECT o.*
    FROM johns j
    JOIN {{ ref('silver_orders') }} o
        ON o.customer_id = j.customer_id
),

sales_by_currency AS (
    SELECT
        currency,
        SUM(price) AS total_revenue_local_currency
    FROM john_orders
    GROUP BY currency
)

SELECT
    s.currency,
    s.total_revenue_local_currency,
    -- column name kept as in the original target table (typo preserved for compatibility)
    s.total_revenue_local_currency * c.to_aud AS total_recenue_aud
FROM sales_by_currency s
JOIN {{ ref('bronze_ref_currency') }} c
    ON s.currency = c.code
