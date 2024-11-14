select
  md5(source_key) as id_dim_customer,
  source_key,
  code,
  name
from {{ ref('transf_dim_customer') }}