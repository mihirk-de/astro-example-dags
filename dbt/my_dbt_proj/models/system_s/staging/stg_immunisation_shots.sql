-- models/system_s/staging/stg_immunisationshots.sql

WITH source AS (
    SELECT
        shotid AS shot_id,
        name AS name,
        drugid AS drug_id,
        intervaltype AS interval_type,
        methodid AS method_id,
        doseid AS dose_id,
        batchno AS batch_no,
        mininterval AS min_interval,
        maxinterval AS max_interval,
        defaultsite AS default_site,
        expirydate AS expiry_date,
        tradename AS trade_name,
        manufacturer AS manufacturer,
        comment AS comment,
        status AS status,
        claimformid AS claim_form_id,
        vaccineidentifierid AS vaccine_identifier_id,
        issystemlocked AS is_system_locked,
        shotnumber AS shot_number,
        keyidentifier AS key_identifier,
        vaccinetypeid AS vaccine_type_id,
        gp_practice_id AS gp_practice_id
    FROM {{ source('system_s', 'immunisationshots') }}
)

SELECT
    shot_id,
    name,
    drug_id,
    interval_type,
    method_id,
    dose_id,
    batch_no,
    min_interval,
    max_interval,
    default_site,
    expiry_date,
    trade_name,
    manufacturer,
    comment,
    status,
    claim_form_id,
    vaccine_identifier_id,
    is_system_locked,
    shot_number,
    key_identifier,
    vaccine_type_id,
    gp_practice_id
FROM source
