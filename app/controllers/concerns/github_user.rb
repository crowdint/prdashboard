class GithubUser
  attr_accessor :id, :nickname, :avatar, :url

  def initialize(params)
    @id       = params[:id]
    @nickname = params[:login]
    @avatar   = params[:avatar_url]
    @url      = params[:html_url]
  end
end
