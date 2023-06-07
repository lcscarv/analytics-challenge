{% snapshot snp_employee_registration %}

{{
    config(
      target_schema='snapshots',
      target_database="people",
      strategy='check',
      unique_key='"ID Bitrix"',
      check_cols= ["status", '"Formação"', "escolaridade",'"Cidade (Residencia)"', '"UF (residencia)"']
    )
}}

select * 
from {{ source('raw_sheets', 'pessoas') }}

{% endsnapshot %}