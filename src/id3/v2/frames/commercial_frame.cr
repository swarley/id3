require "./basic"

module ID3
  module V2
    class CommericalFrame < BasicFrame
      getter :price, :valid_until, :contact_url, :recieved_as, :name_of_seller, :description, :picture_mime

      def format_data
        get_encoding
        @price = get_to_null.as String
        date_str = gets(8)
        @valid_until = Time.new(date_str[0..3].to_i, date_str[4..5].to_i, date_str[6..7].to_i)
        @contact_url = get_to_null.as String
        @recieved_as = get_byte.as UInt8
        @name_of_seller = get_to_null.as String
        @description = get_to_null.as String
        @picture_mime = get_to_null.as String
        # @seller_logo = nil
      end
    end
  end
end
