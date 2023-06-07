{% snapshot snp_managers %}

{{
    config(
      target_schema='snapshots',
      target_database="people",
      strategy='check',
      unique_key='"ID do Bitrix"',
      check_cols=["status", "equipe", 'Time', "squad", '"Gestor de projeto"', '"Líder Equipe"', "dpm", "dpl", "techlead", "teamlead"],
      tags="gp"
    )
}}

select *
from {{ source('raw_sheets', 'squads') }}

{% endsnapshot %}