from airflow import DAG
from airflow.operators.bash import BashOperator
from pendulum import datetime

with DAG("check_dbt_installed", start_date=datetime(2024, 1, 1), schedule=None, catchup=False):
    check_dbt = BashOperator(
        task_id="check_dbt",
        bash_command="which dbt && dbt --version"
    )
