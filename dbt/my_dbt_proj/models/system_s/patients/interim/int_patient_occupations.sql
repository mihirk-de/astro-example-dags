-- models/system_s/protocols/interim/int_patient_occupations.sql
WITH source AS (
  SELECT *
  FROM {{ ref('stg_patient_occupations') }}
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY patient_id, gp_practice_id
      ORDER BY occupation_id DESC
    ) AS row_num
  FROM source
)
SELECT * EXCLUDE(row_num)
FROM ranked
WHERE row_num = 1
