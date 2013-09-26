#encoding: utf-8
require 'error_msg'
require File.expand_path("../utils.rb", __FILE__)

module Booking
  module API
    module Room
      include Booking::API::Utils
      include ErrorMsg
 
      def get_rooms(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getRooms", options)
      end
    end
  end
end
