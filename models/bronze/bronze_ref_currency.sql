{{ config(materialized='table') }}

select * from {{ ref('ref_currency') }}
