# Dropbox Email Project
# Date -- July 1, 2012
#
# Author -- Anirudddha Deshpande

require '/home/aniruddha/Dropbox/dropbox-ruby-sdk-1.3.1/lib/dropbox_sdk'
require 'pp'


APP_KEY = '99i31dzp6dv0irr'
APP_SECRET = 'a8rl77bn5og8bwt'
ACCESS_TYPE = :dropbox

class DropboxEmail
	
	def initialize
		# Create an object of class DropboxSession defined in lib 'dropbox_sdk'
		@session = DropboxSession.new(APP_KEY, APP_SECRET)
		@client = nil
		@a_file = nil
	end

	def login
		# Check if session is already authorized
		if @session.authorized?
			puts "Already logged in!"
		else

			@session.set_access_token('glxwspzjx6clqtg', 'p0tiwixzly0bps7')
=begin	
			@session.get_request_token

		
		
		# To get authorization URL, a 'token key' and a 'token secret' is requested
		
		auth_url = @session.get_authorize_url
		puts "Request Token key is #{@session.request_token.key} and token secret is #{@session.request_token.secret}"
		

		# Click link to authorize the session
		puts "Click to authorize ", auth_url

		gets 
		@session.get_access_token
=end
		end

	puts "Your access token is #{@session.access_token.key} and secret is #{@session.access_token.secret}"

		@client = DropboxClient.new(@session, ACCESS_TYPE)

	end

	# Upload files from temp folder to destination folder on Dropbox
	def put(file, destFolder)
			@a_file = file						# Get a copy of attachment 			
			# Call Dropbox Client
			@client.put_file(destFolder+"/"+file, open(file))
			puts "Uploaded: "+file
	end

	# List files in 'folder' on Dropbox
	def list(folder)
		c = 0
		folder = '/' + folder			
		resp = @client.metadata(folder)
		puts "\n List of contents in " + folder + "\n"
		for item in resp['contents']		
			puts item['path']

			c=c+1
		end	
		
	end
	
	
	def get_link
		resp = @client.metadata('Public/' + @a_file)
		temp = resp['path'].split('/')
		link = 'http://dl.dropbox.com/u/88664019/data/' + temp[3]
		return link
	end

	
	def get_ftype
		resp = @client.metadata('Public/' + @a_file)
		ftype = resp['mime_type']
		return ftype
	end
end


