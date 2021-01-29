control '🏷️  ' do
  title 'Environmental Variables'
  desc 'Check the ENV variable in the shell environment are configured to integrate with the different 3rd parties services.'
  describe os_env('SONARCLOUD_TOKEN') do its('content') { should_not be nil }  end
  describe os_env('CODACY_TOKEN') do its('content') { should_not be nil } end
  describe os_env('SNYK_TOKEN') do its('content') { should_not be nil } end
end



control '⚙️ ' do
  title 'Necessary applications'
  desc 'Check if the auxiliary applications are correctly installed.'
  describe command('brew --version') do its('exit_status') { should eq 0 } end
  describe command('gh --version')   do its('exit_status') { should eq 0 } end
  describe command('jq --version')   do its('exit_status') { should eq 0 } end
  describe command('curl --version') do its('exit_status') { should eq 0 } end
end



control '📁 ' do
  title 'Directories Structure'
  desc 'Chek the new repository directory structure.'
  describe directory('./.git') do it { should exist } end
  describe directory('./.github/workflows') do it { should exist } end
  describe directory('./node_modules') do it { should exist } end
  describe directory('./src') do it { should exist } end
  describe directory('./test') do it { should exist } end
end



control '🗃️  ' do
  title 'Files Structure'
  desc 'Check the new repository files structure.'
  describe file('package.json') do it { should exist } end
  describe file('sonar-project.properties') do it { should exist } end
  describe file('commitlint.config.js') do it { should exist } end
  describe file('.github/workflows/build.yml') do it { should exist } end
  describe file('.github/workflows/codecov.yml') do it { should exist } end
  describe file('.github/workflows/snyk.yml') do it { should exist } end
  describe file('.github/workflows/sonarcloud.yml') do it { should exist } end
end



control '🧪 ' do
  title 'Jest Framework'
  desc 'Jest is configure and is running properly.'
  describe npm('jest') do it { should be_installed } end
  describe command('./node_modules/jest/bin/jest.js') do
    it { should exist }
    its('exit_status') { should eq 0 }
  end
end



control '🤐 ' do
  title 'GitHub repository secrets'
  desc 'Check if the secrets are created in the new repository.'
  describe command('gh secret list -R undeadgrishnackh/`basename "$PWD"`') do
    its('stdout') { should include 'SNYK_TOKEN' }
    its('stdout') { should include 'SONAR_TOKEN' }
  end
end