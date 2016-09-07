require 'factory_config'
require './device_message'
#require 'active_support/core_ext/kernel/reporting'

describe "DeviceMessage" do
	
	before(:all) do
		@data = FactoryGirl.attributes_for(:message_one)[:params_data]
		@device_message = DeviceMessage.add_message @data
	end

	context "add message" do 
		
		it "should return a new instance of class" do 
			#expect(@message).to be_a DeviceMessage
			@device_message.class.should == DeviceMessage
		end
		it "should set user_id correctly" do 
			@device_message.user_id.should == @data[:properties][:user_id]
		end
		it "should set message correctly" do 
			message = " You have following notifications  10"
			@device_message.message.should == message
		end
		it "should set message_type correctly" do 
			@device_message.message_type.should == @data[:payload][:options][:notification_type]
		end
		it "should set pop_up correctly" do 
			@device_message.pop_up.should == @data[:payload][:options][:silent]
		end
		it "should set publish_at correctly" do 
			@device_message.publish_at.should == @data[:properties][:effective_date]
		end
		it "should set target correctly" do 
			@device_message.target.should == "apn"
		end

		it "should set device_ids correctly" do 
			@device_message.device_ids.should == "e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96"
		end
	end

	it "#to_s" do 
    capture { @device_message.to_s }.string.should == FactoryGirl.attributes_for(:message_in_string)[:output_in_string]
	end

end
