class GithubService
  attr_accessor :github, :token

  def initialize(token)
    @token = token
    @github = Github.new oauth_token: token
  end

  def get_pull_requests(organization)
    Rails.cache.fetch('#{cache_key(organization)}/pulls', expires_in: 5.minutes) do
      pull_requests = []
      issues = github.issues.list org: organization, filter: 'all'

      issues.each_page do |page|
        page.each do |issue|
          pull_requests << PullRequest.new(issue) if issue['pull_request']
        end
      end

      pull_requests
    end
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
    Rails.cache.fetch("#{cache_key}/diff/#{params[:repo]}/#{params[:id]}}", expires_in: 5.minutes) do
      `curl -H "Authorization: token #{token}" -H "Accept: application/vnd.github.v3.diff" https://api.github.com/repos/#{params[:repo]}/pulls/#{params[:id]}.diff`
    end
  end

  private

  def cache_key(organization = nil)
    Digest::MD5.hexdigest("#{@token}#{organization}")
  end

end

