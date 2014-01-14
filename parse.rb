require 'gmail'
require 'pp'

	
	
	PATTERN = [ /[dD][iI][sS][pP][lL][aA][yY]/, /[cC][lL][aA][sS][sS]/, /[sS][uU][bB][jJ][eE][cC][tT]/, /[tT][yY][pP][eE]/, /[fF][iI][lL][eE]/ ]

	lines = Array.new	# Array to store all lines of the Email Message	
	main_text = Array.new	# Array to store the main body of the Message
	
	gmail = Gmail.new('dropbox.ruby', 'rubydropbox') # Login	
	inbx = gmail.inbox
	
	email = inbx.emails.last 
		
	text = email.text_part # Get text part of Emails

	abc = text.to_s # Convert Message to string
			
	# Copy each line of message in an array
	c = 0	
	abc.each_line.each do |item|
			
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
	
	puts "---------------Main text-----------------------------------"
	puts main_text	
		
	table = Hash.new							# Key => Value pair Table
	table.clear	
	for line in main_text
		for pat in PATTERN
			temp = line.match(pat)
			 if temp!= nil
				key = temp.to_s					# Convert MatchData to String
				value = line.split(':')				# Get value from matched line	
				table[key.downcase] = value[1].strip		# Downcase 'Key' and store Formatted 'Value' in table
				break
			 end						
		end
		
	end
	
	puts "----------------Key => Value pair Table---------------------"	
	puts table
		
