select 
  c.date_day,
  p.description,
  sum(i.quantity) as qty,
  sum(i.total_amount_exc_vat) as total_amount_exc_vat,
  sum(i.total_amount_inc_vat) as total_amount_inc_vat
from {{ ref('fact_invoice') }} i
join {{ ref('dim_product') }} p on i.id_dim_product = p.id_dim_product
join {{ ref('dim_calendar') }} cl on i.id_dim_calendar = cl.id_dim_calendar
group by 
  c.date_day,
  p.description