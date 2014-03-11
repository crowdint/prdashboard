class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid      = auth['uid']
      user.name     = auth['info']['name']
      user.email    = auth['info']['email']
      user.nickname = auth['info']['nickname']
      user.avatar   = auth['info']['image']
    end
  end

end

