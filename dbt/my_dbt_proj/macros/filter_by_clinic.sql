{% macro filter_by_clinic(alias="", column="gp_practice_id", var_name="gp_practice_id") %}
    {% if alias %}
        {{ alias }}.{{ column }} = '{{ var(var_name) }}'
    {% else %}
        {{ column }} = '{{ var(var_name) }}'
    {% endif %}
{% endmacro %}
