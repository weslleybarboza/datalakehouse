with source as (
      select * from {{ source('landing_zone', 'invoices') }}
),
renamed as (
    select
        {{ adapter.quote("Invoice") }},
        {{ adapter.quote("StockCode") }},
        {{ adapter.quote("Description") }},
        {{ adapter.quote("Quantity") }},
        {{ adapter.quote("InvoiceDate") }},
        {{ adapter.quote("Price") }},
        {{ adapter.quote("Customer ID") }},
        {{ adapter.quote("Country") }}

    from source
)
select * from renamed
  