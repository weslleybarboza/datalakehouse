with source as (
    select * from {{ ref('invoices') }}
)
, set_field_type as (
    select
      CAST(invoice AS VARCHAR) as invoice,
      CAST(StockCode AS VARCHAR) as stock_code,
      CAST(Description AS VARCHAR) as description, 

      /*created macros to handle with conversions - check on dbts/lakehouse/macros/conversions.sql */
      {{ convert_to_decimal('Quantity') }} Quantity,
      {{ convert_to_datetime('InvoiceDate') }} as invoice_date,
      {{ convert_to_decimal('Price') }}  as price,

      CAST("Customer ID" AS VARCHAR) as customer_id,
      CAST(Country AS VARCHAR) as country
    from source
)
select * from set_field_type