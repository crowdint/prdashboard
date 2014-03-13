class PullRequest
  attr_accessor :id, :title, :url, :user, :created_at, :repository, :comments_count, :number

  def initialize(params)
    @id             = params[:id]
    @title          = params[:title]
    @url            = params[:html_url]
    @user           = GithubUser.new(params[:user])
    @created_at     = params[:created_at]
    @repository     = Repository.new(params[:repository])
    @comments_count = params[:comments]
    @number         = params[:number]
  end

end

