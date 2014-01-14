$LOAD_PATH << '/home/aniruddha/dump/ruby/'
require 'getmail'
require 'dropbox'
require 'cpush'

PATTERN = [ /^[dD][iI][sS][pP][lL][aA][yY]/, /^[cC][lL][aA][sS][sS]/, /^[sS][uU][bB][jJ][eE][cC][tT]/,  /^[fF][iI][lL][eE]/ ]


#while 1
		
	mobj = Mailstuff.new
	mails = mobj.get_unread						# Get all unread emails
	obj = DropboxEmail.new
	obj.login
	for mail in mails						# Select mail one by one
		str = String.new	
		mobj.get_attachments(mail)				# Download all the attachments of a mail in 'data' folder
		all_files = Dir["data/*[!~]"]				# Get contents of 'data' folder
		
		if all_files[0] != nil					# Check if attachments are retrieved
						
			file_count = all_files.size			# Get number of Attachments						
			table = Array.new(file_count, Hash.new)		# Create table for each attachment
			i = 0

			for file in all_files				# Select each attachment
							
				obj.put(file,'Public')			# Upload each attachment of a mail
							
				link = obj.get_link			# Generate link for the attachment
				ftype = obj.get_ftype			# Get file type
			
				mobj.parse(table[i],mail,link,ftype)	# Parse email and store all values in Table
				#appcelerate(table[i])				
				
				table[i].each do |x, y|
					str = str + "\n" +"#{x} => #{y}"
				end
				str = str + "\n\n"			
				i = i + 1				# New Table for next attachment
			end

			puts str

			for file in all_files				# Empty 'data' folder
				File.delete(file)		
			end
			
			puts "Folder emptied!"
							
			table.clear
			str.clear					# Clear table entries
		end
		
	end
	
	obj.list('Public/data')						# List contents of 'Public' folder	
	
	mobj.gmail_logout	
#	sleep 60
#end		




