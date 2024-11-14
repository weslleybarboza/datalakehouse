with source as (
select * from {{ ref('load_invoices') }}
)
, getting_unique_codes as (
select 
  distinct
  s.country as source_key,
  s.country as code,
  s.country as country
from source s
)
, mapping_values as (
select
  CASE
      WHEN code = 'Channel Islands' THEN 'JEY'
      WHEN code = 'Netherlands' THEN 'NLD'
      WHEN code = 'Hong Kong' THEN 'HKG'
      WHEN code = 'EIRE' THEN 'IRL'
      WHEN code = 'Korea' THEN 'KOR'
      WHEN code = 'United Kingdom' THEN 'GBR'
      WHEN code = 'RSA' THEN 'ZAF'
      WHEN code = 'U.K.' THEN 'GBR'
      ELSE code
  END as code,
  source_key,
  country
from getting_unique_codes
)
, data_enrich as (
select * 
from mapping_values a
left join {{ ref('seed_country') }} b on (upper(a.code) = b.name_english or upper(a.code) = b.iso_3166_1_alpha3)
)
select * from data_enrich