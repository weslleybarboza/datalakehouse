from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
from cosmos.profiles import PostgresUserPasswordProfileMapping
from datetime import datetime
import os

cron_schedule = None

dbt_project_path = "/opt/airflow/dbts/lakehouse"

dbt_profile_path = f"{dbt_project_path}/profiles.yml"

airflow_dag_name = 'dbt_refresh_data_warehouse_full_model'

profile_config = ProfileConfig(
    profile_name="lakehouse",
    profiles_yml_filepath=dbt_profile_path,
    target_name="dev"
)

my_cosmos_dag = DbtDag(
    project_config=ProjectConfig(dbt_project_path=dbt_project_path),
    profile_config=profile_config,
    operator_args={
        "install_deps": True,
        "full_refresh": False,
    },
    execution_config=ExecutionConfig(
        dbt_executable_path=dbt_project_path,
    ),
    schedule = cron_schedule,
    start_date=datetime(2024, 8, 3),
    catchup=False,
    dag_id=airflow_dag_name,
    default_args={
        'owner': 'customer',
        "retries": 1
        },
)