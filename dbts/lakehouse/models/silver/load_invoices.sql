with source as (
    select * from {{ ref('invoices') }}
)
, set_field_type as (
    select
      /*created macros to handle with conversions - check on dbts/lakehouse/macros/conversions.sql */
      {{ convert_to_varchar('invoice') }} AS invoice,
      {{ convert_to_varchar('StockCode') }} AS stock_code,
      {{ convert_to_varchar('Description') }} AS description,

      {{ convert_to_decimal('Quantity') }} quantity,
      {{ convert_to_datetime('InvoiceDate') }} as invoice_date,
      {{ convert_to_decimal('Price') }}  as price,

      {{ convert_to_varchar('"Customer ID"') }} AS customer_id,
      {{ convert_to_varchar('Country') }} AS country

    from source
)
select * from set_field_type