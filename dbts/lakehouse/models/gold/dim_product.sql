select
  md5(source_key) id_dim_product,
  source_key,
  code,
  description
from {{ ref('transf_dim_product') }}