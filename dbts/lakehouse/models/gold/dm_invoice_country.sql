select 
  cl.date_day,
  c.region_name,
  c.sub_region_code,
  c.country,
  sum(i.quantity) as qty,
  sum(i.total_amount_exc_vat) as total_amount_exc_vat,
  sum(i.total_amount_inc_vat) as total_amount_inc_vat
from {{ ref('fact_invoice') }} i
join {{ ref('dim_country') }} c on i.id_dim_country = c.id_dim_country
join {{ ref('dim_calendar') }} cl on i.id_dim_calendar = cl.id_dim_calendar
group by 
  cl.date_day,
  c.region_name,
  c.sub_region_code,
  c.country