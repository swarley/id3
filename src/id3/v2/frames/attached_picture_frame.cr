# WARNING : UNTESTED AND PROBABLY NOT FUNCTIONAL
require "./basic"

module ID3
  module V2
    class AttachedPicture < BasicFrame
      def format_data
        get_encoding
        @mime_type = get_to_null.as String
        @picture_type = get_byte.as UInt8
        @description = get_to_null.as String
        @picture_data = (gets (size - (@mime_type.as(String).size + @description.as(String).size + 1))).as String
      end
    end
  end
end
