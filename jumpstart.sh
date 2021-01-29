#!/usr/bin/env bash
NUMBER_PARAMETERS=$#
NEW_REPO_NAME=$1
TRUE=0
FALSE=1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source ${DIR}/src/functions.gh.sh
source ${DIR}/src/functions.integrate.sh
# ---------------------------------------------------------------------------

welcome
check_new_repo_mane
install_gh_if_necessary
gh_authentication_check
check_it_is_NOT_a_git_repository
clone_the_repo_from_the_template
pull_the_main_branch
tune_the_package_json
npm_install
npm_test
integrate_with_the_external_analysis_tools
git_push_all_the_tuning
enjoy
