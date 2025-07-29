from airflow import DAG
from airflow.operators.bash import BashOperator
from pendulum import datetime

features = [
    "system_s.patients.refined",
    "system_s.consultation.refined",
    "system_s.prescription.refined",
    "system_s.immunisation.refined",
    "system_s.investigation.refined",
    "system_s.protocols.refined",
    "system_s.cdm.refined",
    "system_s.baseline.refined",
]

with DAG("run_system_s_dbt_features", start_date=datetime(2024, 1, 1), schedule=None, catchup=False):
    tasks = []

    for i, feature in enumerate(features):
        task = BashOperator(
            task_id=f"run_{feature.replace('.', '_')}",
            bash_command=f"""
            echo "$SNOWFLAKE_PRIVATE_KEY_BASE64" | base64 -d > /tmp/rsa_key.p8 && 
            export SNOWFLAKE_PRIVATE_KEY_PATH=/tmp/rsa_key.p8 && 
            cd /usr/local/airflow/dbt/my_dbt_proj && 
            dbt build --select {feature} --profiles-dir /usr/local/airflow/dbt/profiles
            """
        )
        if i > 0:
            tasks[-1] >> task  # serial chaining
        tasks.append(task)

