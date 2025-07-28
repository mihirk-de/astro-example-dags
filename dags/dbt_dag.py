from airflow import DAG
from airflow.operators.bash import BashOperator
from pendulum import datetime

features = [
    "system_s.patients.refined",
    "system_s.consultation.refined"
]

with DAG("run_system_s_dbt_features", start_date=datetime(2024, 1, 1), schedule=None, catchup=False):
#     run_model = BashOperator(
#         task_id="run_system_s_features",
#         # bash_command="cd /usr/local/airflow/dbt/my_dbt_proj && dbt run --profiles-dir /usr/local/airflow/dbt/profiles"
#         bash_command="""echo "$SNOWFLAKE_PRIVATE_KEY_BASE64" | base64 -d > /tmp/rsa_key.p8 && 
# export SNOWFLAKE_PRIVATE_KEY_PATH=/tmp/rsa_key.p8 && 
# cd /usr/local/airflow/dbt/my_dbt_proj && 
# dbt run --profiles-dir /usr/local/airflow/dbt/profiles
# """
#     )
    tasks = []
    # for feature in features:
    #     task = BashOperator(
    #         task_id=f"run_{feature.replace('.', '_')}",
    #         bash_command=f"""
    #         echo "$SNOWFLAKE_PRIVATE_KEY_BASE64" | base64 -d > /tmp/rsa_key.p8 && 
    #         export SNOWFLAKE_PRIVATE_KEY_PATH=/tmp/rsa_key.p8 && 
    #         cd /usr/local/airflow/dbt/my_dbt_proj && 
    #         dbt build --select {feature} --profiles-dir /usr/local/airflow/dbt/profiles
    #         """
    #     )
    #     tasks.append(task)

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

