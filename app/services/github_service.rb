class GithubService
  attr_accessor :github, :token

  def initialize(token)
    @token = token
    @github = Github.new oauth_token: token
  end

  def get_pull_requests(organization)
    Rails.cache.fetch("#{cache_key}/#{organization}/pulls", expires_in: 5.minutes) do
      pulls = []

      repos_for(organization).each do |repo|
        if repo.issues_count > 0
          pull_requests = github.pull_requests.list(user: organization, repo: repo.name, auto_pagination: true)

          pull_requests.each do |pull|
            pulls << PullRequest.new(pull)
          end
        end
      end

      pulls
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

  def create_pull_comment(params)
    user, repo = get_user_repo(params)

    github.issues.comments.create user, repo, params[:pull], body: params[:text]
  end

  def get_pull_comments(params)
    comments_list = []
    user, repo = get_user_repo(params)

    comments = github.issues.comments.list(user, repo, issue_id: params[:pull], auto_pagination: true)

    comments.each do |comment|
      comments_list << Comment.new(comment)
    end

    comments_list
  end

  private

  def repos_for(organization)
    repos = []

    github.repos.list(org: organization, auto_pagination: true).each do |repo|
      repos << OpenStruct.new(name: repo['name'], issues_count: repo['open_issues_count'])
    end

    repos
  end

  def cache_key
    Digest::MD5.hexdigest("#{@token}")
  end

  def get_user_repo(params)
    info = params[:repo].split('/')
    [ info.first, info.last ]
  end

end

