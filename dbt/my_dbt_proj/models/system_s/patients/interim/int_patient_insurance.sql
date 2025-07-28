WITH
  ins AS (
    SELECT i.*, s.scheme_name
    FROM {{ ref('stg_insurance') }} i
    INNER JOIN {{ ref('stg_insurance_scheme') }} s
      ON i.insurance_scheme_id = s.scheme_id
      and {{ match_clinic_value('i', 's') }}
),
  pt AS (
    SELECT *
    FROM {{ ref('stg_patient_types') }}
)

SELECT
  pd.patient_id                                           AS patient_id,
  pd.gp_practice_id                                       AS gp_practice_id,
  pt.patient_type                                    AS patient_type,
  ins.insurance_status_code                               AS status,
  pd.gms_num                                   AS public_card_number,
  pd.gms_review                              AS public_card_review_date
FROM {{ ref('int_patient_details') }} pd
LEFT JOIN pt
  ON pd.patient_type = pt.type_id
  and {{ match_clinic_value('pd', 'pt') }}
LEFT JOIN ins
  ON pd.patient_id = ins.patient_id
  and {{ match_clinic_value('pd', 'ins') }}
