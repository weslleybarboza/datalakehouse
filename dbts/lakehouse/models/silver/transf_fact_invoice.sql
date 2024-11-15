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
  customer_id,
  country,
  cast(sum((quantity * price) / (1 + 0.18)) as decimal(14,4)) as total_amount_exc_vat,
  cast(sum(quantity * price) as decimal(14,4)) as total_amount_inc_vat,
  sum(quantity) quantity
from source
group by
  invoice,
  stock_code,
  invoice_date,
  customer_id,
  country
)
select * from aggregation
