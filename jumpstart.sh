#!/usr/bin/env bash
NUMBER_PARAMETERS=$#
NEW_REPO_NAME=$1
TRUE=0
FALSE=1

function welcome () {
  echo "👋 Welcome to the NODEJS kata repository jumpstart..."
}

function check_new_repo_mane () {
  if [ "$NUMBER_PARAMETERS" -eq  "0" ]; then
    echo "😖 No <repository_name> supplied..."
    exit 1
  fi

  if [ $NUMBER_PARAMETERS -gt 1 ]; then
    echo "😲 Too many parameters! ⚠️ The <repository_name> can be only one word."
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
  echo "┌───────────────────────────────────────────────────────────────"
  echo "│ BREW 🍺 will be installed 📀 on your system"
  echo "│ for further instruction check https://brew.sh/index"
  echo "└───────────────────────────────────────────────────────────────"
  echo " "
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ $? -ne 0 ]; then 
    echo "💥 HomeBrew 🚱 installation terminated with unexpected exit code..."
    exit 1
  fi
}

function install_gh () {
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
  fi

  brew install gh
  if [ $? -ne 0 ]; then 
    echo "💥 GitHub client 🙀 installation terminated with unexpected exit code..."
    exit 1
  fi
}

function install_gh_if_necessary () {
  is_gh_installed
  if [[ $? -eq $FALSE ]] ; then 
    echo '🙀 GH is not installed. Just a sex I am fixing it...'
    echo " "
    install_gh;
  fi
}

function gh_authentication_check () {
  echo "🔐 GH login check..."
  gh auth status
  if [ $? -ne 0 ]; then 
    exit 1
  fi
}

function clone_the_repo_from_the_template () {
  echo "⚙️  cloning the template repo"
  cd ..
  gh repo create $NEW_REPO_NAME --public --confirm --template="undeadgrishnackh/template-nodejs"  
  if [ $? -ne 0 ]; then 
    echo "💥 GitHub client 🙀 terminated with an unexpected exit code..."
    exit 1
  fi
  cd $NEW_REPO_NAME
  if [ $? -ne 0 ]; then 
    echo "💥 the $NEW_REPO_NAME directory doesn't exit..."
    exit 1
  fi
}

function pull_the_main_branch () {
  echo "⚙️  pulling the MAIN branch"
  for i in {1..5}; do     
    git pull origin main --rebase && break || sleep 5;
    echo "⏱️ it can take a while. Let me work on it... 🚧"
  done

  # git pull origin main --rebase
  if [ $? -ne 0 ]; then 
    echo "💥 GitHub client 🙀 wasn't able to pull the MAIN branch from origin..."
    exit 1
  fi
  git branch -M main
  if [ $? -ne 0 ]; then 
    echo "💥 GitHub client 🙀 wasn't able to switch on the MAIN branch..."
    exit 1
  fi
}

function tune_the_package_json () {
  echo "🔬 tuning the package.json for the new repository..."
}

function npm_install () {
  echo "🚧🚧🚧 npm install 🚧🚧🚧"
}

function git_push_all_the_tuning () {
  exit 0
  git add --all
  git commit -m "chore: tuned the template to the new repo."
  git push --set-upstream origin main
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
git_push_all_the_tuning