#encoding: utf-8
require 'error_msg'

module Booking
  module BP
    module Common
      include ErrorMsg

      def common_get_all(client, method_name, options = {"offset" => 0}, &block)
        assert(client)
        assert(client.is_a?(Booking::Client))
        assert(block, "block cannot be nil")
        begin
          options["rows"] = 1000 if !options["rows"] || options["rows"] > 1000
          options["offset"] = 0 if !options["offset"]
          while true
            hash = client.send("#{method_name}", options)
            if hash[:code] != CodeOk
              logger.info("#{hash[:error_msg]}")
              break
            end
            yield(hash[:data][:list]) if block_given?
            if hash[:data][:has_more]
              options["offset"] += options["rows"]
            else
              break
            end
          end
        rescue => e
          logger.info("#{e.message}")
          logger.info("options => #{options.inspect}")
          raise(e)
        end
      end
    end
  end
end
