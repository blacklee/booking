#encoding: utf-8
require 'error_msg'

module Booking
  module BP
    module Hotel
      include Booking::BP::Common
      include ErrorMsg

      def get_rooms(client, options = {"offset" => 0, "languagecodes" => ['en'], "rows" => 3}, &block)
        common_get_all(client, "get_rooms", options) do |hash_array|
          yield(hash_array) if block_given?
        end
      end
    end
  end
end
