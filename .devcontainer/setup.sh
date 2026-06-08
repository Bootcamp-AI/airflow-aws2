#!/bin/bash
set -e

#mkdir -p /workspaces/airflow-aws/src

export AIRFLOW_HOME=~/airflow
AIRFLOW_VERSION=2.9.0
PYTHON_VERSION="$(python --version | cut -d ' ' -f 2 | cut -d '.' -f 1-2)"
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"

pip install "apache-airflow==${AIRFLOW_VERSION}"

echo "🗄️ Inicializando base de datos..."
airflow db migrate

cat > ~/airflow/webserver_config.py << 'EOF'
WTF_CSRF_ENABLED = False
EOF

echo "👤 Creando usuario admin..."
airflow users create \
  --username admin \
  --password admin \
  --firstname Admin \
  --lastname User \
  --role Admin \
  --email admin@example.com

echo "✅ Setup completo. Airflow listo."

#cat >> ~/airflow/airflow.cfg << 'EOF'
#[webserver]
#base_url = https://${CODESPACE_NAME}-8080.app.github.dev
#EOF