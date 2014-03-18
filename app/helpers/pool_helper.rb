module PoolHelper
	def error_message_for(field, options = {:prepend_text => ""})
		error_message = @pool.errors[field][0]
		if error_message
			raw "#{options[:prepend_text]}"
		end
	end
end