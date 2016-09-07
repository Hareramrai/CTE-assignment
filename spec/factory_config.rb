require 'factory_girl'
require 'stringio'

module Kernel

  def capture
    out = StringIO.new
    $stdout = out
    yield
    return out
    ensure
    $stdout = STDOUT
  end
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
  end
  config.expect_with(:rspec) { |c| c.syntax = :should }

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation 
end

FactoryGirl.define do
  factory(:message_one, class: Hash) do
   	params_data({
		  "properties": {
		    "user_id":43,
		    "managing_user_id":43,
		    "description":"Push Notification",
		    "effective_date":"2015-07-20T06:28:36-05:00",
		    "system_date":"2015-07-20T06:28:36-05:00"
		  },
		  "payload":{
	      "id": 49,
	      "options": {
	        "devices": "ios => e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96",
	        "alert_message": " You have following notifications ",
	        "badge_count":10,
	        "created_at":"2015-07-20T06:28:36-05:00",
	        "id":48,
	        "member_id":25,
	        "notification_type": "secure_message",
	        "silent":true,
	        "updated_at":"2015-07-20T06:28:36-05:00"
	      }
		  }  
		})
  end

  factory(:message_two, class: Hash) do 
		params_data({
		"properties": {
			"user_id": 43,
			"managing_user_id": 43,
			"description": "Push Notification",
			"effective_date": "2015-07-21T06:28:36-05:00",
			"system_date": "2015-07-21T06:28:36-05:00"
		},
		"payload":
			{
				"id": 48,
				"options": {
				  "devices": "android => e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96",
				  "alert_message": "This is a sample push notification message",
				  "badge_count": 0,
				  "created_at": "2015-07-21T06:28:36-05:00",
				  "id":48,
				  "member_id": 25,
				  "notification_type": "Reminder",
				  "silent": false,
				  "updated_at": "2015-07-21T06:28:36-05:00"
				}
			}
		})
  end

  factory(:message_in_string, class: String) do
  	output_in_string <<-EOM
user_id: 43
message:  You have following notifications  10
message_type: secure_message
pop_up: true
publish_at: 2015-07-20T06:28:36-05:00
target: apn
device_ids: e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96
EOM
  end


end

