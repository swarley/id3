require "./basic.cr"

module ID3
  module V2
    class CommentsFrame < BasicFrame
      getter :language, :description, :text

      def format_data
        get_encoding
        @language = gets(3).as String
        @description = get_to_null.as String
        @text = get_to_null.as String
      end
    end
  end
end
