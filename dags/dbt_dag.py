from airflow import DAG
from airflow.operators.bash import BashOperator
from pendulum import datetime

# with DAG("check_dbt_installed", start_date=datetime(2024, 1, 1), schedule=None, catchup=False):
#     check_dbt = BashOperator(
#         task_id="check_dbt",
#         bash_command="which dbt && dbt --version"
#     )

with DAG("run_dbt_model", start_date=datetime(2024, 1, 1), schedule=None, catchup=False):
    run_model = BashOperator(
        task_id="run_customer_model",
        bash_command="cd /usr/app/dbt/my_dbt_proj && dbt run --profiles-dir /usr/app/dbt/profiles"
    )
