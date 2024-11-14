WITH source AS (
    SELECT * 
    FROM {{ ref('load_invoices') }}
)
,getting_unique_codes AS (
    SELECT DISTINCT
        stock_code AS source_key,
        stock_code AS code,
        description
    FROM source 
)
,ranked_descriptions AS (
    SELECT 
        source_key,
        code,
        description,
        ROW_NUMBER() OVER (PARTITION BY code ORDER BY description DESC) as ranking
    FROM getting_unique_codes
)
,completeness AS (
    SELECT 
        source_key,
        code,
        CASE 
            WHEN description = '-' THEN CONCAT('PRODUCT ', code)
            ELSE description
        END AS description,
        ranking
    FROM ranked_descriptions
)
SELECT 
    source_key,
    code,
    description
FROM completeness
WHERE ranking = 1