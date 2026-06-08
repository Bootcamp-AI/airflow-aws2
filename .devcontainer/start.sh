#!/bin/bash
sleep 5
export AIRFLOW_HOME=~/airflow
export AIRFLOW__WEBSERVER__ENABLE_PROXY_FIX=True
export AIRFLOW__CORE__DAGS_FOLDER=/workspaces/airflow-aws/dags

if [ -n "$CODESPACE_NAME" ]; then
  BASE_URL="https://${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
  echo "🌐 Configurando base_url: $BASE_URL"
  sed -i "s|^base_url.*|base_url = ${BASE_URL}|" ~/airflow/airflow.cfg
fi

mkdir -p ~/airflow/dags
cp -r ./dags/. ~/airflow/dags/ 2>/dev/null || true

echo "🚀 Init Airflow..."
airflow standalone >> ~/airflow/airflow.log 2>&1