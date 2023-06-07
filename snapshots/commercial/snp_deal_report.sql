{% snapshot snp_deal_report %}

{{
    config(
      target_schema='snapshots', 
      target_database="commercial",
      strategy='check',
      unique_key='"ID"',
      check_cols=['"ID"', 'title', 'closed', 'is_new', 'opened', 'lead_id', 'type_id', '"COMMENTS"', 'quote_id', 'stage_id', 'utm_term', 'contacts', 'products', 'begindate', 'closedate', 'origin_id', 'source_id', 'tax_value', 'company_id', 'contact_id', 'utm_medium', 'utm_source', 'category_id', 'currency_id', 'date_create', 'date_modify', 'location_id', 'opportunity', 'probability','user_fields', 'utm_content', 'is_recurring', 'modify_by_id', 'utm_campaign', 'created_by_id', 'originator_id', 'assigned_by_id', 'additional_info', 'stage_semantic_id', 'is_return_customer', 'source_description', 'is_repeated_approach', 'tracking_channel_code']
    )
}}

select * 
from {{ source('raw_bitrix', 'bitrix_deal_report') }}

{% endsnapshot %}