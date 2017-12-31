class Organization
  attr_accessor :id, :name, :avatar

  def initialize(params)
    @id     = params[:id]
    @name   = params[:login]
    @avatar = params[:avatar_url]
  end
end
