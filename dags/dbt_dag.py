from airflow import DAG
from airflow.operators.bash import BashOperator
from pendulum import datetime

# with DAG("check_dbt_installed", start_date=datetime(2024, 1, 1), schedule=None, catchup=False):
#     check_dbt = BashOperator(
#         task_id="check_dbt",
#         bash_command="which dbt && dbt --version"
#     )

# with DAG("list_usr_app", start_date=datetime(2024, 1, 1), schedule=None, catchup=False):
#     find_dbt = BashOperator(
#         task_id="locate_dbt_project",
#         bash_command="""
#         echo "🔍 Searching for dbt_project.yml..."
#         find / -name dbt_project.yml 2>/dev/null

#         echo "\n🔍 Searching for folders named 'dbt'..."
#         find / -type d -name dbt 2>/dev/null

#         echo "\n🔍 Listing large folders to find your repo..."
#         du -h --max-depth=2 / | sort -hr | head -n 20
#         """,
#     )

with DAG("run_dbt_model", start_date=datetime(2024, 1, 1), schedule=None, catchup=False):
    run_model = BashOperator(
        task_id="run_customer_model",
        # bash_command="cd /usr/local/airflow/dbt/my_dbt_proj && dbt run --profiles-dir /usr/local/airflow/dbt/profiles"
        bash_command="""echo "$SNOWFLAKE_PRIVATE_KEY_BASE64" | base64 -d > /tmp/rsa_key.p8 && 
export SNOWFLAKE_PRIVATE_KEY_PATH=/tmp/rsa_key.p8 && 
cd /usr/local/airflow/dbt/my_dbt_proj && 
dbt run --profiles-dir /usr/local/airflow/dbt/profiles
"""
    )
