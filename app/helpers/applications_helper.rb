module ApplicationsHelper
	def rand_text
		text = SecureRandom.hex[0..8]	
		text ||=''
		text	
  end
end
