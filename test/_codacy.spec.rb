control '🔌 ' do
  title 'Codacy Integration'
  desc 'Check if the integration phase created the new project into Codacy.'
  describe command('curl "https://app.codacy.com/api/v3/analysis/organizations/gh/undeadgrishnackh/repositories?limit=100" -H "api-token: `echo ${CODACY_TOKEN}`" --compressed > /tmp/.CodacyRepositories.json') do
    its('exit_status') { should eq 0 }
  end
  describe command('grep "`basename "$PWD"`" /tmp/.CodacyRepositories.json') do
    its('exit_status') { should eq 0 }
  end  
end
