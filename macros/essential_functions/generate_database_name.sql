{% macro generate_database_name(custom_database_name, node) -%}

    {%- set default_database = target.database -%}
    
    {% if target.name == 'prod' %}

    {{ custom_database_name | trim }}

    {%- else -%}

        {{ default_database }}

    {%- endif -%}

{%- endmacro %}