-- models/system_s/protocols/interim/int_patient_details.sql

WITH source AS (
  SELECT *
  FROM {{ ref('stg_patient_details') }}
  WHERE active = TRUE           -- only live records
)

-- If you still want the safety of ROW_NUMBER(), you can keep this:
-- ranked AS (
  {# SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY patient_id, gp_practice_id
      ORDER BY date_modified DESC, details_id DESC
    ) AS row_num
  FROM source
) #}

SELECT
  -- If you’re confident active = TRUE gives exactly one row, just:
  * 
FROM source

-- Or, if you’d rather guard against bad data:
-- SELECT * EXCEPT(row_num)
-- FROM ranked
-- WHERE row_num = 1;

