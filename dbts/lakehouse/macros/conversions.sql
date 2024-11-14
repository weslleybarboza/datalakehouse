{% macro convert_to_decimal(field) %}
CASE 
    WHEN REGEXP_MATCHES( {{ field }} , '[^0-9.-]') THEN 0 
    ELSE CAST( {{ field }} AS DECIMAL(15,4))
END
{% endmacro %}

{% macro convert_to_datetime(field) %}
CASE
    WHEN CAST(split_part({{ field }}, '/', 2) AS INT) > 12 THEN TO_TIMESTAMP({{ field }}, 'MM/DD/YYYY HH24:MI')
    ELSE TO_TIMESTAMP({{ field }}, 'DD/MM/YYYY HH24:MI')
END
{% endmacro %}

{% macro convert_to_varchar(field) %}
CASE
    WHEN TRIM( CAST({{field}} AS VARCHAR)) = '' THEN '-'
    WHEN TRIM( CAST({{field}} AS VARCHAR)) IS NULL THEN '-'
    ELSE TRIM( CAST({{field}} AS VARCHAR))
END
{% endmacro %}