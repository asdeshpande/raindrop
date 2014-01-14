require 'mail'
require 'gmail'
require 'pp'

gmail = Gmail.new('dropbox.ruby', 'rubydropbox')
email = gmail.inbox.emails
mail = email.last
puts mail.from
link = 'www.google.com'
str = 'abc'
s = pp str
sender = 'anirudhsdeshpande@gmail.com'
	gmail.deliver do
	 	to sender
		subject "File uploaded successfully !"
	 	text_part do	
			body	"Acknowledgement
				 Link = " + link + "
				 Details = " + s
				
		end
	end 

