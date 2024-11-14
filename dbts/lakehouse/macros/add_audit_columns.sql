{% macro add_audit_columns() %}
  , current_timestamp as rec_inserted_at
  , current_timestamp as rec_updated_at
{% endmacro %}
