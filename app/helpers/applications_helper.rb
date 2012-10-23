module ApplicationsHelper
	def rand_text
		chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789'
		length = rand(chars.size/4)
		text = ''
		length.times { |i| text << chars[rand(chars.length)] }
		text
  end
end
