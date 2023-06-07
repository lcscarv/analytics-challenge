{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- set public_schema = "public" -%}

    {%- if target.name == 'prod' -%}

        {%- if custom_schema_name is none -%}

            {{ public_schema }}

        {%- else -%}

            {{ custom_schema_name | trim }}

        {%- endif -%}

    {%- else -%}

        {{ default_schema }}

    {%- endif -%}

{%- endmacro %}