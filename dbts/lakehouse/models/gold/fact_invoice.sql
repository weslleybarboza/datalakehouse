select
  concat(invoice, '|', stock_code) as source_key,
  quantity,
  price,
  18 vat,
  cast((quantity * price) / (1 + 0.18) as decimal(14,4)) as total_amount_exc_vat,
  cast(quantity * price as decimal(14,4)) as total_amount_inc_vat,
  md5(stock_code) as id_dim_product,
  md5(customer_id) as id_dim_customer,
  md5(country) as id_dim_country
from {{ ref('transf_fact_invoice') }}