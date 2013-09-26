#encoding: utf-8

module Booking
  class BestPractice
    include Booking::BP::Location
    include Booking::BP::Hotel
  end
end
