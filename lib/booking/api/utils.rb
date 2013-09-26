#encoding: utf-8
require 'error_msg'

module Booking
  module API
    module Utils
      include ErrorMsg
      NormalHost = "distribution-xml.booking.com"
      # just handle request to host: distribution-xml.booking.com
      def request_booking_get(booking_method, params = {}, expect_resp_code = 200)
        params.each_pair {|k, v| params[k.to_s] = v}
        if params["languagecodes"].is_a?(Array)
          params["languagecodes"] = params["languagecodes"].join(',')
        end
        if params["city_id"] || params["city_ids"]
          city_ids = params["city_ids"].split(',') rescue []
          city_ids << params["city_id"] if params["city_id"]
          params.delete("city_id")
          params["city_ids"] = city_ids.join(',')
        end
        if params["hotel_id"] || params["hotel_ids"]
          hotel_ids = params["hotel_ids"].split(',') rescue []
          hotel_ids << params["hotel_id"] if params["hotel_id"]
          params.delete("hotel_id")
          params["hotel_ids"] = hotel_ids.join(',')
        end
        if params["district_id"] || params["district_ids"]
          district_ids = params["district_ids"].split(',') rescue []
          district_ids << params["district_id"] if params["district_id"]
          params.delete("district_id")
          params["district_ids"] = district_ids.join(',')
        end
        if params["last_change"]
          if params["last_change"].is_a?(Time) || params["last_change"].is_a?(Date)
            params["last_change"] = params["last_change"].date_ptn
          end
        end
        str_url = "https://#{NormalHost}/json/bookings.#{booking_method}"
        str_url += "?#{params.to_query.gsub("%2C", ",")}"
        logger.info(str_url)
        uri = URI.parse(str_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth(self.username, self.password)
        resp = http.request(request)
        hash = {:response => resp, :http_code => resp.code}
        if resp.code.to_i == expect_resp_code
          hash[:code] = CodeOk
        else
          hash[:code] = CodeError
          hash[:error_msg] = "unexpected HTTP response status: #{resp.code}"
        end
        hash
      end
 
      def booking_common_get(booking_method, options = {"rows" => 3, "languagecodes" => ['en']})
        resp = request_booking_get(booking_method, options)
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
 
      def request_booking_post(str_url, params = {})
          assert(params.is_a?(Hash))
          uri = URI.parse(str_url)
          puts str_url
          request = Net::HTTP::Post.new(uri.request_uri)
          request_body = params.to_query
      end
 
        def logger
          @logger ||= begin
            Rails.logger rescue Logger.new(STDOUT)
          end
        end    
    end
  end
end
