#encoding: utf-8
require 'error_msg'

module Booking
  module BP
    module Location
      include Booking::API::Location
      include Booking::API::Utils
      include ErrorMsg

      def get_all_cities
        offset = 0
        limit = 1000
        while true
          hash = get_cities({"rows" => limit, "offset" => offset, "languagecodes" => ['en']})
          if hash[:code] != CodeOk
            logger.info("#{hash[:error_msg]}")
            break
          end
          hash[:data][:list].each do |hotel|
          end
          if hash[:data][:has_more]
            offset += limit
          else
            break
          end
        end
      end
    end
  end
end
