class OauthController < ApplicationController

# Facebook Oauth Api
	def facebook_oauth
     
      if params["code"].present? && params["redirect_url"].present?
	      user_details = Oauth.facebookAccessTokenCheckWithCode(params["code"],params["redirect_url"])
		  render :json => {:status => true,:details => user_details}
	  else
	  	 render :json => {:status => false,:details => "Missing params"}
	  end
	
	end

end
