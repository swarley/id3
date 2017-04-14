module ID3
  module V2
    class BasicFrame
      @data : String | Nil
      @name : String
      getter :header

      def initialize(@header : FrameHeader)
        @name = "NO NAME"
        @data = nil
        format_data
      end

      def format_data
      end

      def access_mode : Bool
        @header.access_mode
      end

      def grouping_identity : Bool
        @header.grouping_identity
      end

      def encryption : Bool
        @header.encryption
      end

      def compression : Bool
        @header.compression
      end

      def file_alter_perservation : Symbol
        @header.file_alter_perservation
      end

      def tag_alter_preservation : Symbol
        @header.tag_alter_preservation
      end

      def size : Int
        @header.size
      end

      def gets(int : Int) : String
        return @header.source.gets(int).as String
      end

      def gets(str : String) : String
        return @header.source.gets(str).as String
      end

      def get_byte : UInt8
        return @header.source.read_byte.as UInt8
      end

      def get_to_null : String
        return @header.source.gets('\0', @header.size)
      end

      def get_data : String
        return @header.source.gets(@header.size)
      end
    end
  end
end
