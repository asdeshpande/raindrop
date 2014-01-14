# -----------------
# WORK IN PROGRESS!
#------------------

require 'curb'
require 'pp'
require 'json'

def appcelerate(params)
	
	a=params.to_json
	b=a.to_s
	str='fields='+b
	
	
	c = Curl::Easy.http_post("https://api.cloud.appcelerator.com/v1/objects/batch29/create.json?key=CT7i1i7XqtHglCy5dxx3zPVl84eQAzak",str) do |curl|
		curl.enable_cookies =  true
		curl.cookiefile = 'login.info'
		curl.cookiejar = 'login.info'
		curl.verbose = true
		puts curl.body_str
	end	


#b=params.to_s
#a='fields='
#str=a+b
#puts str
#c.perform
pp c.body_str
end
