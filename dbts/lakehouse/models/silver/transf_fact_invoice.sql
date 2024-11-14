with source as (
select
  invoice,
  stock_code,
  quantity,
  invoice_date,
  price,
  customer_id,
  country
from {{ ref('load_invoices') }}
)
, aggregation as (
select
  invoice,
  stock_code,
  invoice_date,
  price,
  customer_id,
  country,
  sum(quantity) quantity
from source
group by
  invoice,
  stock_code,
  invoice_date,
  price,
  customer_id,
  country
)
select * from aggregation
