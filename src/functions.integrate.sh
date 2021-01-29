#!/usr/bin/env bash

function integrate_with_the_external_analysis_tools () {
  echo " "
  echo "🔌 Integration with the external analysis platforms."
  connect_with_sonarcloud
  connect_with_snyk
  connect_with_codacay
}

function connect_with_sonarcloud () {
  echo "🧙‍♀️ Sonarcloud connection in progress..."
  if [ "${SONARCLOUD_TOKEN}" = "" ]; then 
    echo "☹️ your SONARCLOUD_TOKEN environmental variable isn't defined."    
    echo "⚠️ export the token into your .*shrc"
    echo "🔗 please read more here: https://docs.sonarqube.org/latest/extend/web-api/#WebAPI-UserToken"
    echo "💥 Sonarcloud integration failed."
    return
  else
    create_the_github_sonarcloud_secret
    browse_the_GitHub_repositories
    get_the_new_repository_UID
    create_the_new_sonarcloud_project
  fi
  echo "🚀 Sonarcloud connected."
}

function connect_with_snyk () {
  echo "👮 Snyk connection in progress..."
  echo "🔍 Search for the SNYK_TOKEN..."
  if [ "${SNYK_TOKEN}" = "" ]; then 
    echo "☹️ your SNYK_TOKEN environmental variable isn't defined."
    echo "⚠️ install snyk client and export the token into your .*shrc"
    echo "🔗 to install the client read here: https://github.com/snyk/snyk#installation"
    echo "   to get the API token run 'snyk config get api'."
    echo "💥 Snyk integration failed."
    return
  else
    echo "🔑 SNYK_TOKEN secret creation in progress..."
    gh secret set SNYK_TOKEN -R "undeadgrishnackh/${NEW_REPO_NAME}" -b "${SNYK_TOKEN}"
  fi
  echo "\n🛡️ Snyk connected."
}
function create_the_github_sonarcloud_secret () {
  echo "🔑 SONAR_TOKEN secret creation in progress..."
  gh secret set SONAR_TOKEN -R "undeadgrishnackh/${NEW_REPO_NAME}" -b "`echo ${SONARCLOUD_TOKEN}`"
  check_return_code $? \
                    "☑️ The secret SONAR_TOKEN is created." \
                    "❌ The creation of the secret SONAR_TOKEN raised an error."
}

function browse_the_GitHub_repositories () {
  echo "🔎 Search for the new GitHub repos..."
  curl -u ${SONARCLOUD_TOKEN}: \
      'https://sonarcloud.io/api/alm_integration/list_repositories?organization=undeadgrishnackh' \
      --compressed > /tmp/.sonarcloud.repositories.js
  sleep 1
}

function get_the_new_repository_UID () {
  echo "🔎 Collect the GitHub project UID..."
  is_jq_installed
  if [[ $? -eq $FALSE ]] ; then 
        echo '😱 JQ  is not installed. Just a sec I am working on it...'
        echo " "
    install_jq;
  else
    echo "☑️  JQ 🕸 is installed."
  fi

  cat /tmp/.sonarcloud.repositories.js | jq | jq '.repositories[].installationKey' > /tmp/.sonarcloud.repositories.installationKeys.js
  grep "/${NEW_REPO_NAME}|" /tmp/.sonarcloud.repositories.installationKeys.js > /tmp/.sonarcloud.repositories.installationKey.js
  echo "💳 the project key is `cat /tmp/.sonarcloud.repositories.installationKey.js`"
}

function is_jq_installed () {
  if ! [ -x "$(command -v jq)" ]; then
    return $FALSE
  fi
  return $TRUE
}

function install_jq () {
  echo "⚙️ Installing JQ to parse the JSON reply..."
  # JsonQuery - https://stedolan.github.io/jq/
  brew install jq
  check_return_code $? 
                    "☑️  JQ 🕸 was installed correctly." 
                    "💥 JQ 🕸 installation terminated with unexpected exit code..."
}

function create_the_new_sonarcloud_project () {
  echo "🦹 Sonarcloud project creation..."
  INSTALLATION_KEY=`cat /tmp/.sonarcloud.repositories.installationKey.js| sed 's/"//g'`
  curl -u ${SONARCLOUD_TOKEN}: \
        'https://sonarcloud.io/api/alm_integration/provision_projects' \
        -H 'Referer: https://sonarcloud.io/projects/create' \
        --data-raw "installationKeys=${INSTALLATION_KEY}&organization=undeadgrishnackh" \
        --compressed
  check_return_code $? \
                    "\n🥳 SonarCloud connected successfully." \
                    "\n❌ SonarCloud connection error. 😰 Don't panic 😱..."
}


function connect_with_codacay () {
  echo "🕵️ Codacy connection in progress..."
  if [ "${CODACY_TOKEN}" = "" ]; then 
    echo "☹️ your CODACY_TOKEN environmental variable isn't defined."
    echo "⚠️ export the token into your .*shrc"
    echo "🔗 read more here: https://docs.codacy.com/related-tools/codacy-api-tokens/"
    echo "💥 Codacy integration failed."
    return
  else
    curl -X POST https://app.codacy.com/api/v3/repositories \
      -H 'Content-Type: application/json' \
      -H "api-token: `echo ${CODACY_TOKEN}`" \
      -d '{"provider":"gh", "repositoryFullPath":"undeadgrishnackh/'${NEW_REPO_NAME}'"}'
    check_return_code $? \
                    "\n📡 Codacy connected successfully." \
                    "\n❌ Codacy connection error. 😰 Don't panic 😱..."
  fi
}