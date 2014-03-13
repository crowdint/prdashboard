class GithubService
  attr_accessor :github, :token

  def initialize(token)
    @token = token
    @github = Github.new oauth_token: token
  end

  def get_pull_requests(organization)
    pull_requests = []
    issues = github.issues.list org: organization, filter: 'all'

    issues.each_page do |page|
      page.each do |issue|
        pull_requests << PullRequest.new(issue) if issue['pull_request']
      end
    end

    pull_requests
  end

  def get_organizations
    orgs = []
    organizations = github.orgs.list

    organizations.each_page do |page|
      page.each do |org|
        orgs << Organization.new(org)
      end
    end

    orgs
  end

  def get_diff(params)
    `curl -H "Authorization: token #{token}" -H "Accept: application/vnd.github.v3.diff" https://api.github.com/repos/#{params[:repo]}/pulls/#{params[:id]}.diff`
  end

end

