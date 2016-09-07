class DeviceMessage

	attr_reader :user_id, :message, :message_type, :pop_up, :publish_at, :target, :device_ids

	def initialize params
		@user_id = params[:user_id]
		@message = get_message params
		@message_type = params[:message_type]
		@pop_up = params[:silent]
		@publish_at = params[:publish_at]
		@target = params[:target]
		@device_ids = params[:device_ids]
	end
	
	class << self 
		def add_message params
			data = parse_data params
			DeviceMessage.new data
		end

		def parse_data params
			data = { }
			options = params[:payload][:options]
			data[:user_id] = params[:properties][:user_id]
			data[:silent] = options[:silent]
			data[:badge_count] = options[:badge_count]
			data[:message_type] = options[:notification_type]
			data[:message_title] = options[:alert_message]
 			data[:publish_at] = params[:properties][:effective_date]
			data[:target] = options[:devices].include?("ios") ? "apn" : "gcm"
			data[:device_ids] = options[:devices].split("=>").last.strip
			data								
		end

	end

	def get_message data
		if data[:silent]
			"#{data[:message_title]} #{data[:badge_count]}" 
		else
			data[:message_title] 
		end
	end

	def to_s
		instance_variables.each do |ivar| 
			puts "#{ivar[1..-1]}: #{instance_variable_get ivar}"
		end
	end 

end
