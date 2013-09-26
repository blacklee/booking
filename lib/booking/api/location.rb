#encoding: utf-8
require 'error_msg'

module Booking
  module API
    module Location
      include Booking::API::Utils  
      include ErrorMsg
      def get_cities(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getCities", options)
      end
 
      def get_countries(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getCountries", options)
      end
 
      def get_districts(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getDistricts", options)
      end
 
      def get_regions(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getRegions", options)
      end
 
 
 
      def get_cities1(options = {"rows" => 3, "languagecodes" => ['en']})
        resp = request_booking_get("getCities", options)
        hash = {:code => resp[:code]}
        if resp[:code] == CodeOk
          list = JSON.parse(resp[:response].body)
          hash[:data] = {
            :list => list,
            :has_more => list.length == options["rows"]
          }
        else
          hash[:error_msg] = resp[:error_msg]
        end
        hash
      end
    end
  end
end
