# Script to retrieve attachments from " dropbox.ruby@gmail.com "
# Date -- July 2, 2012
# Author -- Aniruddha Deshpande
require 'gmail'
require 'pp'  #pretty printer

class Mailstuff

	def initialize
		@gmail = Gmail.new('dropbox.ruby', 'rubydropbox')		
		@unread_emails = @gmail.inbox.emails(:unread)
	end

	def get_unread
		unread = @gmail.inbox.emails(:unread)
		return unread
	end

	def get_attachments(mail)
		
		attachment = mail.attachments			
			for a in attachment
				File.open('data/'+ a.filename,"w+") { |local_file| local_file << a.decoded }
			end
		
	end

	

	def parse(table,mail,link,ftype)
		
				
			lines = Array.new		 # Array to store all lines of the Email Message	
			main_text = Array.new		 # Array to store the main body of the Message
			
			text = mail.text_part		 # Get text part of Emails
		
			string_body = text.to_s 	 # Convert Message to string
					
			# Copy each line of message in an array
			c = 0	
			string_body.each_line.each do |item|
				lines[c] = item
				c= c + 1
			end
		
			
		
			# Copy main body of the message	
			c = lines.size - 1
			i = 0
			while ( c != 5)
				main_text[i] = lines[c]
				c = c-1
				i = i+1		
			end
			
			#puts "---------------Main text-----------------------------------"
			#puts main_text	
				
										
			if main_text != []
				for line in main_text
					for pat in PATTERN
						temp = line.match(pat)
						 if temp!= nil
							temp2 = temp.to_s				# Convert MatchData to String			
							key = temp2.strip					
							value = line.split(':')				# Get value from matched line	
							if key.downcase == 'class'
								table['class'] = value[1].strip
							end
							if key.downcase == 'display'
								table['display_name'] = value[1].strip
							end							
							if key.downcase == 'subject'
								table['subject_name'] = value[1].strip
							end				
							if key.downcase == 'type'
								table['type'] = value[1].strip
							end										
							#table[key.downcase] = value[1].strip		# Downcase 'Key' and store Formatted 'Value' in table
							break
						 end						
					end
					
				end
			end
			
			table['file_path'] = link
			table['ftype'] = ftype
			
			puts "----------------Key => Value pair Table---------------------"	
			puts table

	
			
			main_text.clear
			lines.clear		
		
	end
	

	def gmail_logout
		@gmail.logout
	end

end
			
