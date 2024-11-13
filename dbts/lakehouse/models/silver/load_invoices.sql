with source as (
    select * from {{ ref('invoices') }}
)
, set_field_type as (
    select
      CAST(s.invoice AS VARCHAR) as invoice,
      CAST(s.StockCode AS VARCHAR) as stock_code,
      CAST(s.Description AS VARCHAR) as description,
      CAST(s.Quantity AS DECIMAL(15,4)) as quantity,
      TO_TIMESTAMP(s.InvoiceDate, 'DD/MM/YYYY HH24:MI') as invoice_date,
      CAST(s.Price AS DECIMAL(15,4)) as price,
      CAST(s."Customer ID" AS VARCHAR) as customer_id,
      CAST(s.Country AS VARCHAR) as country
    from source s
)
select * from set_field_type