#!/bin/bash
set -e

cp ./.env.example ./.env
. ./.env

# create rails app
docker compose build
docker compose run --rm app /bin/bash -c "
    rails new ${APP_NAME} --api;
    mv ${APP_NAME}/* ./;
    mv ${APP_NAME}/.* ./;
    rm -rf ${APP_NAME};
"

# helper func
function replace_in_env() {
    sed -i '' "/^$1=/s/=.*/=$2/" ./.env
}

# move master.key to .env file
RAILS_MASTER_KEY_FILE=${SERVER_SRC_PATH}/config/master.key
RAILS_MASTER_KEY=$(cat ${RAILS_MASTER_KEY_FILE})
replace_in_env RAILS_MASTER_KEY ${RAILS_MASTER_KEY}
shred --remove ${RAILS_MASTER_KEY_FILE}

# remove bootstrap script
rm -- "$0"

docker compose build    # build again to add gems from Gemfile
docker compose up

