module ID3
  module V2
    class UserTextFrame < BasicFrame
      getter :encoding, :data, :description

      def format_data
        enc = get_byte

        if enc == 0
          @encoding = "ISO-8859-1"
        else
          @encoding = "UTF-8"
        end

        @description = get_to_null.as String
        @data = get_to_null.as String
      end
    end
  end
end
