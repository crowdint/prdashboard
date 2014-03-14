class Comment
  attr_accessor :id, :body, :username, :avatar

  def initialize(params)
    @id       = params[:id]
    @body     = params[:body]
    @username = params[:user][:login]
    @avatar   = params[:user][:avatar_url]
  end

end

