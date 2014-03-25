module PoolHelper

	def error_message_password1(field)
		error_messagepassword1 = @pool.errors[field]
		if error_messagepassword1
			raw "#{error_messagepassword1[0]}
			<br/>#{error_messagepassword1[1]}"
		end
	end

	def error_message_password2(field)
		error_messagepassword2 = @pool.errors[field]
		if error_messagepassword2
			raw "#{error_messagepassword2[0]}"
		end
	end

end