# FROM quay.io/astronomer/astro-runtime:12.6.0
# Use the Astro Runtime 3.0.5 image (Debian Buster variant)
# FROM quay.io/astronomer/ap-airflow:3.0.5-buster-onbuild
# FROM quay.io/astronomer/astro-runtime:3.0.5-buster-onbuild
FROM astrocrpublic.azurecr.io/runtime:3.0-5
# FROM quay.io/astronomer/astro-runtime:3.0.5-buster
# FROM astrocrpublic.azurecr.io/runtime:3.0-5
pip install dbt-core dbt-snowflake



