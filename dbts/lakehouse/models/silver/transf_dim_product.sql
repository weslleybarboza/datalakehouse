with source as (
select * from {{ ref('load_invoices') }}
)
, getting_unique_codes as (
select 
  distinct
  s.stock_code as source_key,
  s.stock_code as code,
  s.description as description
from source s
)
, completeness as (
select 
  source_key,
  code,
  CASE 
    WHEN description = '-' THEN CONCAT('PRODUCT ', code)
    ELSE description
  end description
from getting_unique_codes
)
select * from completeness
where 1=1