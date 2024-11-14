{{ config(
    post_hook="INSERT INTO {{ this }} (id_dim_calendar, date_day) VALUES ('0', DATE '1900-01-01')"
) }}


select
    date_day
    , md5(cast(extract(year from date_day) as varchar) || 
        lpad(cast(extract(month from date_day) as varchar), 2, '0') || 
        lpad(cast(extract(day from date_day) as varchar), 2, '0')) as id_dim_calendar
    , cast(extract(year from date_day) as varchar) || 
      lpad(cast(extract(month from date_day) as varchar), 2, '0') || 
      lpad(cast(extract(day from date_day) as varchar), 2, '0') as date_yyyymmdd

    -- Day attributes
    , dayofyear(date_day) as day_of_year
    , dayofweek(date_day) as dayofweek
    , CASE 
        WHEN dayofweek(date_day) = '1' THEN 'SUNDAY'
        WHEN dayofweek(date_day) = '2' THEN 'MONDAY'
        WHEN dayofweek(date_day) = '3' THEN 'TUESDAY'
        WHEN dayofweek(date_day) = '4' THEN 'WEDNESDAY'
        WHEN dayofweek(date_day) = '5' THEN 'THURSDAY'
        WHEN dayofweek(date_day) = '6' THEN 'FRIDAY'
        WHEN dayofweek(date_day) = '7' THEN 'SATURDAY'
        ELSE 'N/I'
      END AS dayofweek_name
    , extract(day from date_day) as day_of_month

    -- Week attributes
    , date_add(date_day, -(dayofweek(date_day) )) as week_start_date
    , date_add(date_day, 6 - dayofweek(date_day) ) as week_end_date
    , extract(week from date_day) as week_of_year

    -- Month attributes
    , extract(month from date_day) as month_of_year
    , date_trunc('month', date_day) as month_start_date
    , date_add(date_trunc('month', date_day), 30) as month_end_date  -- Approximate month end

    -- Quarter attributes
    , extract(quarter from date_day) as quarter_of_year
    , date_trunc('quarter', date_day) as quarter_start_date
    , date_add(date_trunc('quarter', date_day), 89) as quarter_end_date  -- Approximate quarter end

    -- Year attributes
    , extract(year from date_day) as year_number
    , date_trunc('year', date_day) as year_start_date
    , date_add(date_trunc('year', date_day), 364) as year_end_date  -- Approximate year end
    {{add_audit_columns()}}

from {{ ref('transf_calendar') }}  -- Reference your pre-generated date table
