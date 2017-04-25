module ID3
  module V2
    class TextFrame < BasicFrame
      def format_data
        get_encoding

        bytes = Bytes.new(size - 1)
        @header.source.read bytes

        @data = String.new(bytes, @encoding.as(String))
      end
    end
  end
end
