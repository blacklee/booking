# Booking

Ruby API to access https://distribution-xml.booking.com/, partial implementation.


## Modules

This gem provides 2 modules to use booking

- API
- BP -> Best Practice

## Usage

Here is a code snappits from my Rails project:

``` ruby
namespace :gm do
  task :refresh_hotels => :environment do |tsk|
    booking_client = Booking::Client.new({:cfg_file => "#{Rails.root.to_s}/config/database.yml"})
    bp = Booking::BestPractice.new
    bp.get_all_hotels(booking_client, 0, 10) do |hotel_hash_array|
      hotel_hash_array.each do |hotel_hash|
        puts hotel_hash
      end
    end
  end
end
``` 
