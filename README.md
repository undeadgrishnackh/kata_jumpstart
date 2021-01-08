# Kata one-click JumpStart

## 🤔 Why do I need a kata jumpstart?
Because frankly speaking no one likes to initialize a new repo all the time we start a kata 😉. It's an annoying and long process. Doing my eXtreme Programming lessons, I figured out that is emerging a funny developer behaviour. Storing all the katas into a sandbox environment. A place where the code is crammed like in a stinky sardine can. Stinky because very often all the quality checkers, and the CD/CI pipelines, are partially or totally missing. And we know, continuous integration is one core tenants of XP! I found it funny; doing katas to improve how we do TDD and at the same time forgetting a so important pillar.
For these reasons I decided to create a jumpstart script that, leveraging the new GitHub template and actions features, is creating in a click an empty and fully configured NodeJS GitHub repo. Potentially it could be extended to create whatever rewport you're looking for (vue.js, java, python, ruby, etc.)

## 📀 How to use it
Clone the repo on your local machine:
```js
gh repo clone undeadgrishnackh/kata_jumpstart
```
Create a link to the script jumpstart.sh, or call it into your own script. This is mine _createNewNodeJSKata_ that at the end open up Visual Studio Code.
```js
#!/usr/bin/env bash
./kata_jumpstart/jumpstart.sh "$1"
cd "$1"
echo " "
echo "🧪 testing time. ⏲️ it takes a while..."
inspec exec ../kata_jumpstart/test/jumpstart.spec.rb --interactive --color --enable-telemetry --show-progress
cd ..
code "$1"
```
Where parameter is the <NEW_REPO_NAME> you wanna create in GitHub and have cloned into your local machine.

⚠️ PS: i was looking to have it working via a **curl | bash** way, but for some reasons, gh creates the remote repo but the local copy is missing and so the script goes in error.

## 🔍 What does the installer do?
- checks and in case installs [GitHub client](https://github.com/cli/cli) and [Homebrew](https://brew.sh/).
- checks your GitHub Auth.
- creates a  new github repository from [my NodeJS teplate](https://github.com/undeadgrishnackh/template-nodejs)
- pulls the new repo on your local PC (main branch)
- tunes the template for the new repository (package.js, sonarcloud, README badges)
- executes _'npm install'_
- executes _'npm test'_
- executes _git add & git push_

## 🔍 What is inside the NodeJS template?
The [template repository](https://github.com/undeadgrishnackh/template-nodejs) is a fully configfured NodeJs repo with:
- jest
- eslint + prettier configured with AirBnB setup
- husky to enforce on git commit the compliance about:
  - eslint rules
  - git commit messages
- GitHub workflows to check:
  - build on Node 14, 15, with the build badge [![build](https://github.com/undeadgrishnackh/template-nodejs/workflows/CI%20Build%20gate./badge.svg)](https://github.com/undeadgrishnackh/template-nodejs/actions?query=workflow%3A%22CI+Build+gate.%22)
  - vulnerability scan with SNYK [![Known Vulnerabilities](https://snyk.io/test/github/undeadgrishnackh/template-nodejs/badge.svg)](https://snyk.io/test/github/undeadgrishnackh/template-nodejs/)
  - codebase analysis with SonarCloud [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=undeadgrishnackh_template-nodejs&metric=alert_status)](https://sonarcloud.io/dashboard?id=undeadgrishnackh_template-nodejs)
  - code coverage hisotrical report with CodeCov [![codecov](https://codecov.io/gh/undeadgrishnackh/template-nodejs/branch/master/graph/badge.svg)](https://codecov.io/gh/undeadgrishnackh/template-nodejs)
- the prebuild badges for:
  - Codacy [![Codacy Badge](https://api.codacy.com/project/badge/Grade/c8e046ebad254148950f6fea8f671594)](https://app.codacy.com/manual/undeadgrishnackh/template-nodejs?utm_source=github.com&utm_medium=referral&utm_content=undeadgrishnackh/template-nodejs&utm_campaign=Badge_Grade_Dashboard)
  - BetterCode [![BCH compliance](https://bettercodehub.com/edge/badge/undeadgrishnackh/template-nodejs?branch=master)](https://bettercodehub.com/)
  - CodeScene [![CodeScene System Mastery](https://codescene.io/projects/7748/status-badges/system-mastery)](https://codescene.io/projects/7748)

## 👨‍💻 post install tuning
After you got your the new repository you can start straight away to code, or you can tune something at the moment I'm still spiking about secrets to make working SNYK, SonarCloud, or to add Codacay, CodeScene, BetterCode.

## 🕵️ I wanna test the final result - 🏗️ _under construction_ 
I would like to have developed the whole thing in TDD, but bash and TDD are still not so friends... so I'm working to do an infrastructure test suite with [chef inspec](https://community.chef.io/tools/chef-inspec/). In the test directory are stored the ♦️ ruby.spec that will check the final result via the jumpstart.test.sh script. 
