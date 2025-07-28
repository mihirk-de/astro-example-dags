WITH source AS (
    SELECT *
    FROM {{ source('system_s', 'patientcontacts') }}
)

SELECT
    contactid             AS contact_id,
    patientid             AS patient_id,
    firstname             AS first_name,
    surname               AS surname,
    dob                   AS date_of_birth,
    gender                AS gender,
    address1              AS address_1,
    address2              AS address_2,
    address3              AS address_3,
    address4              AS address_4,
    phoneno               AS primary_contact_number,
    relationship          AS relationship,
    contacttype           AS contact_type_code,
    status                AS contact_status_code,
    datecreated           AS date_created,
    datemodified          AS date_modified,
    lastupdatedby         AS last_updated_by,
    gp_practice_id        AS gp_practice_id
FROM source
