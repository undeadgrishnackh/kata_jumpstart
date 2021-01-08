describe directory('./.git') do it { should exist } end
describe directory('./node_modules') do it { should exist } end

describe file('package.json') do it { should exist } end
describe file('sonar-project.properties') do it { should exist } end
describe file('commitlint.config.js') do it { should exist } end
describe file('.github/workflows/build.yml') do it { should exist } end
describe file('.github/workflows/codecov.yml') do it { should exist } end
describe file('.github/workflows/snyk.yml') do it { should exist } end
describe file('.github/workflows/sonarcloud.yml') do it { should exist } end

describe npm('jest') do
  it { should be_installed }
end

describe command('./node_modules/jest/bin/jest.js') do
  it { should exist }
  its('exit_status') { should eq 0 }
end