with source as (
select * from {{ ref('load_invoices') }}
)
, getting_unique_codes as (
select 
  distinct
  s.customer_id as source_key,
  s.customer_id as code,
  s.customer_id as description
from source s
)
, completeness as (
select 
  source_key,
  code,
  CONCAT('CUSTOMER NO ', code) name
from getting_unique_codes
)
select * from completeness