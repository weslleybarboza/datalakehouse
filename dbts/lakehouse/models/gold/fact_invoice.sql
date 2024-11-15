select
  concat(invoice, '|', stock_code) as source_key,
  invoice_date,
  quantity,
  18 vat,
  total_amount_exc_vat,
  total_amount_inc_vat,
  md5(stock_code) as id_dim_product,
  md5(customer_id) as id_dim_customer,
  md5(country) as id_dim_country,
  md5(TO_CHAR(invoice_date, 'YYYYMMDD')) as id_dim_calendar
from {{ ref('transf_fact_invoice') }}