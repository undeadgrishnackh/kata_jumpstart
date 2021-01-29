control '🔌 ' do
  title 'SonarCloud Integration'
  desc 'Check if the integration phase created the new project into Sonarcloud.'
  describe command('curl -u ${SONARCLOUD_TOKEN}:  "https://sonarcloud.io/api/components/search_projects?boostNewProjects=true&organization=undeadgrishnackh" --compressed > /tmp/.SonarCloudRepositories.json') do
    its('exit_status') { should eq 0 }
  end
  describe command('grep "`basename "$PWD"`" /tmp/.SonarCloudRepositories.json') do
    its('exit_status') { should eq 0 }
  end  
end