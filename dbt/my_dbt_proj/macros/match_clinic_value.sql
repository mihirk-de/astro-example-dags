{% macro match_clinic_value(left, right, column="gp_practice_id") %}
    {{ left }}.{{ column }} = {{ right }}.{{ column }}
{% endmacro %}
