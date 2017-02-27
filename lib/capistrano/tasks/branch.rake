
before 'deploy:starting', 'deploy:branch_check'
# before 'deploy:pending:log', 'deploy:branch_check'

namespace :deploy do
  task :branch_check do
    branch = fetch(:branch)
    if branch.nil? or branch.empty? or branch == "master"
      warn "      \e[0;31mInvalid or no branch name specified, please set BRANCH env variable when running!\e[0m"
      exit 1
    end
  end
end
