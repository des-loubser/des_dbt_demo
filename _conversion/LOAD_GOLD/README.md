# load_gold.dtsx Conversion

**Schema:** `LOAD_GOLD`
**Converted:** 1/3 models
**Failed:** 2

## Conversion Mapping

Maps each metadata.csv row to generated dbt models:

| SSIS Task Name | dbt Model | Folder | Status | Reason |
|----------------|-----------|--------|--------|--------|
| Truncate GOLD_JOHN_SALES_BY_REGION | - | - | ✗ Failed | DDL/truncate maintenance task only; no transformat... |
| Load GOLD_JOHN_SALES_BY_REGION | load_gold_john_sales_by_region | presentation | ✓ Converted | - |
| Logging if failed | - | - | ✗ Failed | Audit/error logging task with no transformational ... |

## Generated Models

### presentation/ (1 models)

- `load_gold_john_sales_by_region.sql`

## Usage

Reference models:
```sql
{{ ref('load_gold_model_name') }}
```

Models have schema config:
```sql
{{ config(schema="LOAD_GOLD") }}
```

## Snowflake Migration Checklist

- [ ] **`~/.dbt/profiles.yml`** — configure Snowflake connection for profile `load_gold`
- [ ] **`models/sources.yml`** — map SQL Server database names to their Snowflake equivalents
      (e.g. `database: JQODS` → actual Snowflake database name)
- [ ] **T-SQL dialect** — replace unsupported functions in generated models:
      `PARSENAME` → `SPLIT_PART`, `DATEPART(mi,...)` → `MINUTE(...)`,
      `ISDATE(...)` → `TRY_TO_DATE(...) IS NOT NULL`,
      `LIKE '%/[0-9]/%'` → `RLIKE '.*/[0-9]/.*'`
- [ ] **`packages.yml`** — add any required dbt packages then run `dbt deps`
- [ ] **Run `dbt compile`** to surface any remaining source name or syntax errors

## Source Package

Original SSIS package: `load_gold.dtsx`
