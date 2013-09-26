#encoding: utf-8
require 'error_msg'
require File.expand_path("../utils.rb", __FILE__)

module Booking
  module API
    module Hotel
      include Booking::API::Utils
      include ErrorMsg
 
      def get_hotel_description_photos(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getHotelDescriptionPhotos", options)
      end
      def get_hotel_description_translations(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getHotelDescriptionTranslations", options)
      end
      def get_hotel_description_types(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getHotelDescriptionTypes", options)
      end
      def get_hotel_facilities(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getHotelFacilities", options)
      end
      def get_hotel_facility_types(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getHotelFacilityTypes", options)
      end
      def get_hotel_logo_photos(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getHotelLogoPhotos", options)
      end
      def get_hotel_photos(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getHotelPhotos", options)
      end
      def get_hotel_translations(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getHotelTranslations", options)
      end
      def get_hotel_types(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getHotelTypes", options)
      end
      def get_hotels(options = {"rows" => 3, "languagecodes" => ['en']})
        booking_common_get("getHotels", options)
      end
      def get_changed_hotels(options = {"rows" => 3, "languagecodes" => ['en']})
        assert(options["last_change"])
        hash = booking_common_get("getChangedHotels", options)
        #logger.info("get_changed_hotels\t#{options["last_change"]}\t#{hash.to_json}")
        hash
      end
    end
  end
end
