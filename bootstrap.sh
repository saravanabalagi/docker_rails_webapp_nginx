#!/bin/bash
set -e

cp ./.env.example ./.env
. ./.env

# create rails app
docker compose build
docker compose run --rm ruby /bin/bash -c "
    rails new ${APP_NAME} --api --database=postgresql;
    mv ${APP_NAME}/* ./;
    mv ${APP_NAME}/.* ./;
    rm -rf ${APP_NAME};
    apt install -y python3-ruamel.yaml;
    python3 utils/update_db_yml.py;
    rails db:create;
"

# move master.key to .env file
RAILS_MASTER_KEY_FILE=${SERVER_SRC_PATH}/config/master.key
RAILS_MASTER_KEY=$(cat ${RAILS_MASTER_KEY_FILE})
function replace_in_env() { sed -i '' "/^$1=/s/=.*/=$2/" ./.env ; }
replace_in_env RAILS_MASTER_KEY ${RAILS_MASTER_KEY}
shred --remove ${RAILS_MASTER_KEY_FILE}

# remove bootstrap script
rm -- "$0"

# rebuild gems and start server
docker compose build
docker compose up
