
	#def details
		tables = Array.new(2, Hash.new)
			
		tables[0]['cat'] = 'small'
		tables[1]['dog'] = 'big'	

		str =String.new
		puts tables[0]
			
		

		#for table in tables
			tables[0].each do |x, y|
				str = str + "\n" +"#{x} => #{y}"
			end
			str = str + "\n\n"
			tables[1].each do |x, y|
				str = str + "\n" +"#{x} => #{y}"
			end
		#end

puts "String:"
puts str
