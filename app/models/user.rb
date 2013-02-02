class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :username, :web_api_url

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
      user.name = auth["info"]["name"]
      user.web_api_url = auth["extra"]["access_token"].params[:edam_webApiUrlPrefix]
    end
  end
end
