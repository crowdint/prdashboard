class Repository
  attr_accessor :id, :full_name, :url, :description, :private

  def initialize(params)
    @id          = params[:id]
    @full_name   = params[:full_name]
    @url         = params[:html_url]
    @description = params[:description]
    @private     = params[:private]
  end
end
