# load_silver.dtsx Conversion

**Schema:** `LOAD_SILVER`
**Converted:** 2/6 models
**Failed:** 4

## Conversion Mapping

Maps each metadata.csv row to generated dbt models:

| SSIS Task Name | dbt Model | Folder | Status | Reason |
|----------------|-----------|--------|--------|--------|
| Load SILVER_ORDERS.OLE DB Destination | - | - | ✗ Failed | This is an OLE DB Destination component with no SQ... |
| Load SILVER_ORDERS.OLE DB Source | load_silver_orders_ole_db_source | presentation | ✓ Converted | - |
| Load SILVER_CUSTOMERS.OLE DB Destination | - | - | ✗ Failed | This is an OLE DB Destination component with no SQ... |
| Load SILVER_CUSTOMERS.OLE DB Source | load_silver_customers_ole_db_source | presentation | ✓ Converted | - |
| Truncate SILVER_ORDERS | - | - | ✗ Failed | This is a DDL/maintenance task that creates a tabl... |
| Truncate SILVER_CUSTOMERS | - | - | ✗ Failed | This is a DDL/maintenance task that creates a tabl... |

## Generated Models

### presentation/ (2 models)

- `load_silver_orders_ole_db_source.sql`
- `load_silver_customers_ole_db_source.sql`

## Usage

Reference models:
```sql
{{ ref('load_silver_model_name') }}
```

Models have schema config:
```sql
{{ config(schema="LOAD_SILVER") }}
```

## Snowflake Migration Checklist

- [ ] **`~/.dbt/profiles.yml`** — configure Snowflake connection for profile `load_silver`
- [ ] **`models/sources.yml`** — map SQL Server database names to their Snowflake equivalents
      (e.g. `database: JQODS` → actual Snowflake database name)
- [ ] **T-SQL dialect** — replace unsupported functions in generated models:
      `PARSENAME` → `SPLIT_PART`, `DATEPART(mi,...)` → `MINUTE(...)`,
      `ISDATE(...)` → `TRY_TO_DATE(...) IS NOT NULL`,
      `LIKE '%/[0-9]/%'` → `RLIKE '.*/[0-9]/.*'`
- [ ] **`packages.yml`** — add any required dbt packages then run `dbt deps`
- [ ] **Run `dbt compile`** to surface any remaining source name or syntax errors

## Source Package

Original SSIS package: `load_silver.dtsx`
