# README

### Facebook Oauth

<body> 
   Steps:
   1.Create facebook developer acccount
   2.Go to facebook developer page and create App
   3.Get your app client_id and client_secret id
   4.Enter redirect url
</body>

### Facebook Login for Web and Mobile Devices Using Ruby on Rails

include the gem in your Gemfile:

<body>

    gem 'rest-client'
    
</body>


And then execute:

 $ bundle install
   
Steps:

1.rails g model oauth

2.rake db:migrate

3.rails g controller oauth facebook_oauth


## facebook_oauth Functions

 Oauth.rb File

<body>

	 # Get accesstoken using facebook graph Api
  def self.facebookAccessTokenCheckWithCode(code,redirect_uri)
     
      user = Hash.new
      begin
        
        response = RestClient.get "#{'https://graph.facebook.com/oauth/access_token?     client_id=1234&client_secret=1234&redirect_uri='}#{redirect_uri}#{'&code='}#{code}"
        token_res = JSON.parse(response.body)
        if (accessToken = token_res["access_token"])
          user = facebookAccessTokenCheck(accessToken)
        else
          user["res"] = token_res
          user["status"] = false
        end
        
      rescue Exception => e
        user["message"] = e.message
        user["status"] = false
      end
      
      return user
  
  end
  
    # Get information from facebook using accessToken
  def self.facebookAccessTokenCheck(accessToken)
     
     details = Hash.new
      
      begin
         
         response = RestClient.get "#{'https://graph.facebook.com/v2.8/me?fields=first_name,last_name,email,picture.type(small)&access_token='}#{accessToken}"
         profile = JSON.parse(response.body)
         details["unique_id"] =  profile['id']
         details["email"] =  profile['email']
         details["name"] = profile['first_name'] + profile["last_name"]
         details["access_token"] = accessToken
         details["image"] = profile["picture"]["data"]["url"]
         details["provider"] = "facebook"
      rescue Exception => e
         details = e.message
         details["status"] = false

      end
      
      return details
  
  end 

</body>

    routes.rb File:

<body>

  post 'oauth' => "oauth#facebook_oauth"
  
</body>


    Sample Response:

<body>

  {
    "status": true,
    "details":
    {
        "unique_id": "123455",
        "email": "your_fb_email_id",
        "name": "your_fb_username",
        "access_token": "your accesstoken",
        "image": "your_profile_image_path",
        "provider": "facebook",
      }
  }
  
</body>





	





