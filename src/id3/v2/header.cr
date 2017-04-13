require "../error"
require "./synchsafe"

module ID3
  module V2
    class Header
      enum Flags
        Unsynchronisation  = 0b10000000
        ExtendedHeader     = 0b01000000
        ExperimentalHeader = 0b00100000
        Footer             = 0b00010000
      end

      getter :major_version, :minor_version, :flags, :size

      # @str/ID3v2 header anatomy
      #   [
      # 0   'I',
      # 1   'D',
      # 2   '3',
      # 3   MAJOR_VERSION,
      # 4   MINOR_VERSION,
      # 5   FLAGS,
      # 6   SIZE_1, \
      # 7   SIZE_2,  \ All part of one synchsafe int
      # 8   SIZE_3,  /
      # 9   SIZE_4, /
      #   ]
      def initialize(file : File)
        @major_version = 0_u8
        @minor_version = 0_u8
        @flags = 0_u8
        @source = file.dup.as(File)
        @source.seek 0
        str = @source.gets(10)

        if str.nil?
          @str = ""
          raise Error::DecodingError.new("File small for tag")
        else
          @str = str
        end

        # Check for ID3v2-ness
        raise Error::DecodingError.new("Invalid tag ID") unless @str[0..2] == "ID3"

        get_info
      end

      def unsynchronisation? : Bool
        return ((@flags & Flags::Unsynchronisation) > 0)
      end

      def extended_header? : Bool
        return (@flags & Flags::ExtendedHeader) > 0
      end

      def experimental? : Bool
        return (@flags & Flags::Experimental) > 0
      end

      def footer? : Bool
        return (@flags & Flags::Footer) > 0
      end

      private def get_info
        get_version
        get_flags
        get_size
      end

      private def get_version
        @major_version = @str[3].ord.to_u8
        @minor_version = @str[4].ord.to_u8
      end

      private def get_flags
        @flags = @str[5].ord.to_u8
      end

      private def get_size
        @size = ID3::V2.synchsafe_decode ID3::V2.get_synchsafe(@str[6..9].bytes)
      end
    end
  end
end
