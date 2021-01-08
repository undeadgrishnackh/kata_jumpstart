#!/usr/bin/env bash
NUMBER_PARAMETERS=$#
NEW_REPO_NAME=$1
TRUE=0
FALSE=1

function check_return_code () {
  # $1 = return code passed by $?
  # $2 = command successful message
  # $3 = error message
  [[ $1 -eq 0  ]] && echo "$2" || echo "$3"
}
function check_for_errors () {
  check_return_code $1 "$2" "$3"
  [[ $1 -ne 0  ]] && exit 1
}

function ensure_the_directory_is_the_new_repository () {
  [[ "$PWD" =~ "$NEW_REPO_NAME"  ]] && return $TRUE || echo "💥 seem the repository directory isn't created correctly!" 
  exit 1
}

function welcome () {
  clear
  echo "👋 Welcome to the NODEJS kata repository jumpstart..."
  echo "──────────────────────────────────────────────────────"
}

function check_new_repo_mane () {
  if [ "$NUMBER_PARAMETERS" -eq  "0" ]; then
    echo "😖 The new repository name that must be created cloning the template wasn't supplied..."
    echo " "
    echo "ℹ️  command sintax: jumpstart <new_repository_name>"
    echo " "
    exit 1
  fi

  if [ $NUMBER_PARAMETERS -gt 1 ]; then
    echo "😲 Too many parameters!"
    echo "ℹ️ command sintax: jumpstart <new_repository_name>"
    exit 1
  fi
}

function is_gh_installed () {
  if ! [ -x "$(command -v gh)" ]; then
    return $FALSE
  fi
  return $TRUE
}

function is_brew_installed () {
  if ! [ -x "$(command -v brew)" ]; then
    return $FALSE
  fi
  return $TRUE
}

function install_brew () {
  echo " "
  echo "┌───────────────────────────────────────────────────────────────"
  echo "│ BREW 🍺 will be installed 📀 on your system"
  echo "│ for further instruction check https://brew.sh/index"
  echo "└───────────────────────────────────────────────────────────────"
  echo " "
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  check_for_errors $? "☑️  BREW 🍺 was installed correctly." "💥 HomeBrew 🚱 installation terminated with unexpected exit code..."
}

function install_gh () {
  echo " "
  echo "┌───────────────────────────────────────────────────────────────" 
  echo "│ GH 😺 will be installed 📀 on your system"
  echo "│ For further instruction on the official GitHub client check"
  echo "│ https://github.com/cli/cli"
  echo "└───────────────────────────────────────────────────────────────"
  echo " "
  is_brew_installed
  if [[ $? -eq $FALSE ]] ; then 
        echo '😱 BREW 🍺 is not installed. Just a sex I am working on it...'
        echo " "
    install_brew;
  else
    echo "☑️  BREW 🍺 is installed."
  fi

  brew install gh
  check_for_errors $? "☑️  GitHub Client 😺 was installed correctly." "💥 GitHub client 🙀 installation terminated with unexpected exit code..."
}

function install_gh_if_necessary () {
  is_gh_installed
  if [[ $? -eq $FALSE ]] ; then 
    echo "🙀 GH is not installed. Just a sex I am fixing it..."
    echo " "
    install_gh;
  else
    echo "☑️  GitHub Client 😺 is installed."
  fi
}

function gh_authentication_check () {
  echo " "
  echo "🔐 GH login check..."
  gh auth status
  if [ $? -ne 0 ]; then 
    exit 1
  fi
}

function clone_the_repo_from_the_template () {
  echo " "
  echo "⚙️  cloning the template repo"
  gh repo create $NEW_REPO_NAME --public --confirm --template="undeadgrishnackh/template-nodejs"
  check_for_errors $? "☑️  Repository cloned correctly"  "💥 GitHub client 🙀 terminated with an unexpected exit code..." 

  echo `pwd`
  cd "$NEW_REPO_NAME"
  check_for_errors $?  "☑️  Repository local directory created correctly"  "💥 the $NEW_REPO_NAME directory doesn't exit..."
}

function pull_the_main_branch () {
  echo " "
  echo "⚙️  pulling the MAIN branch"
  ensure_the_directory_is_the_new_repository
  for i in {1..5}; do     
    git pull origin main --rebase && break || echo "⏱️  it can take a while. Let me work on it... 🚧";    
    sleep 5
  done
  check_for_errors $? "☑️  MAIN branch pulled correctly from the new GitHub repo"  "💥 GitHub client 🙀 wasn't able to pull the MAIN branch from origin..." 

  git branch -M main 
  check_for_errors $? "☑️  Local git switched correctly to the MAIN branch"  "💥 GitHub client 🙀 wasn't able to switch on the MAIN branch..." 

}

function tune_the_package_json () {
  echo " "
  echo "🔬 tuning the template parameters for the new repository..."
  ensure_the_directory_is_the_new_repository

  echo "🔍 seeking for the package.json parameters to update"
  sed -i '' 's/template-nodejs/'${NEW_REPO_NAME}'/g' package.json
  check_return_code $? "☑️  package.json tuned up." "💥 package.json isn't tuned correctly!"

  echo "🔍 seeking for the sonar cloud parameters to update"
  sed -i '' 's/template-nodejs/'${NEW_REPO_NAME}'/g' sonar-project.properties
  check_return_code $? "☑️  sonar-project.properties tuned up." "💥 sonar-project.properties isn't tuned correctly!"

  echo "🔍 seeking for the README parameters to update"
  sed -i '' 's/template-nodejs/'${NEW_REPO_NAME}'/g' README.md
  check_return_code $? "☑️  README.md tuned up." "💥 README.md isn't tuned correctly!"
}

function npm_install () {
  echo " "
  echo "🚧 npm install 🚧"  
  echo "⏱️  long operation ahead, be patience..."
  ensure_the_directory_is_the_new_repository
  npm install
  check_for_errors $? "☑️  npm install completed." "💥 npm install exploded 💣💣💣..."
}

function npm_test () {
  echo " "
  echo "📊 time to test if everything is working..."
  ensure_the_directory_is_the_new_repository
  npm test
  check_return_code $? "☑️  npm test setup correctly." "💥 npm test exploded 💣💣💣..."
}

function git_push_all_the_tuning () {
  echo " "
  echo "🔏 time to write and lock the updates into GitHub."
  ensure_the_directory_is_the_new_repository
  git add --all
  git commit -m "chore: tuned the template to the new repo"
  check_for_errors $? "☑️  All the tuned files added to git." "💥 something went wrong during the commit into git..." 
  
  git push --set-upstream origin main
  check_for_errors $? "☑️  everything is committed into GitHub." "💥 pushing the files into GitHub raised a critical error..." 
}

function enjoy () {
  echo " "
  echo "🥳 Enjoy! The repo is ready to rock 🤘 Update the README.md and code... 📟"
}


# ---------------------------------------------------------------------------

welcome
check_new_repo_mane
install_gh_if_necessary
gh_authentication_check
clone_the_repo_from_the_template
pull_the_main_branch
tune_the_package_json
npm_install
npm_test
git_push_all_the_tuning
enjoy
