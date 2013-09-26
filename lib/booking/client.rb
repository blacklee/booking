#encoding: utf-8

module Booking
  class Client
    attr_reader :username, :password
    include Booking::API::Location
    include Booking::API::Hotel
    include Booking::API::Room
    def initialize(options={})
      cfg_file = options[:cfg_file] || options["cfg_file"]
      if !cfg_file || !File.exists?(cfg_file)
        raise "Configuration file is not specified or not exists.\t#{cfg_file}"
      end
      cfg_hash = YAML.load_file(cfg_file)
      @username = cfg_hash["booking"]["username"]
      @password = cfg_hash["booking"]["password"]
    end

    def hi
      msg = "hello there"
      puts msg
      msg
    end
  end
end

