{% snapshot snp_lead_report %}

{{
    config(
      target_schema='snapshots',
      target_database="commercial",
      strategy='check',
      unique_key='"ID"',
      check_cols=['"ID"', '"NAME"', 'post', 'title', 'opened', 'address', '"COMMENTS"', 'has_imol', 'utm_term', 'address_2', 'birthdate', 'email1_id', 'email2_id', 'email3_id', 'has_email', 'has_phone', 'honorific', 'last_name', 'origin_id', 'source_id', 'status_id', 'company_id', 'contact_id', 'phone_1_id', 'phone_2_id', 'phone_3_id', 'utm_medium', 'utm_source', 'currency_id', 'date_closed', 'date_create', 'date_modify', 'opportunity', 'second_name', 'utm_content', 'address_city', 'email1_value', 'email2_value', 'email3_value', 'modify_by_id', 'utm_campaign', 'company_title', 'created_by_id', 'originator_id', 'phone_1_value', 'phone_2_value', 'phone_3_value', 'address_region', 'assigned_by_id', 'email1_type_id', 'email2_type_id', 'email3_type_id', 'address_country', 'phone_1_type_id', 'phone_2_type_id', 'phone_3_type_id', 'address_province', 'email1_value_type', 'email2_value_type', 'email3_value_type', 'uf_crm_1543412748', 'uf_crm_1611751246', 'uf_crm_1624037382', 'uf_crm_1624037407', 'uf_crm_1624300038', 'uf_crm_1625172307', 'uf_crm_1626181971', 'is_return_customer', 'phone_1_value_type', 'phone_2_value_type', 'phone_3_value_type', 'source_description', 'status_description', 'status_semantic_id', 'address_loc_addr_id', 'address_postal_code', 'address_country_code', 'uf_crm_1543338591441', 'is_manual_opportunity']
    )
}}

select * 
from {{ source('raw_bitrix', 'bitrix_lead_report') }}

{% endsnapshot %}