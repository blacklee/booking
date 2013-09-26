#encoding: utf-8
require 'error_msg'

module Booking
  module BP
    module Common
    end
    module Hotel
      include Booking::BP::Common
      include ErrorMsg

      def get_all_hotels(client, options = {"offset" => 0, "languagecodes" => ['en'], "rows" => 3}, &block)
        common_get_all(client, "get_hotels", options) do |hotel_hash_array|
          yield(hotel_hash_array) if block_given?
        end
      end

      def get_all_hotel_photos(client, options = {"offset" => 0, "languagecodes" => ['en'], "rows" => 3}, &block)
        common_get_all(client, "get_hotel_photos", options) do |hotel_photo_hash_array|
          yield(hotel_photo_hash_array) if block_given?
        end
      end

      def get_changed_hotels(client, options = {"offset" => 0, "languagecodes" => ['en'], "rows" => 1000}, &block)
        common_get_all(client, "get_changed_hotels", options) do |hash_array|
          yield(hash_array) if block_given?
        end
      end

      def get_hotel_translations(client, options = {"rows" => 3, "languagecodes" => ['en']})
        common_get_all(client, "get_hotel_translations", options) do |hash_array|
          yield(hash_array) if block_given?
        end
      end

    end
  end
end
