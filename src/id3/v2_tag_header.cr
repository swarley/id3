require "./synchsafe"

module ID3
  ID3_IDENTIFIER = [73, 68, 51]

  module V2
    class Header
      # @size : Int32
      getter :major_version, :minor_version
      getter :flag
      getter :size
      getter :unsynchronisation, :extended_header, :experimental, :footer

      def initialize(str : String)
        @source = File.open str
      end

      def initialize(@source : File)
        # ID3 Header is 10bytes, less than that is impossible
        raise "File too short to be ID3" if @source.size < 10
        @source.seek 0
        # Create slices for IO#read(s : Slice(T))
        id_slice = Slice(UInt8).new(3)
        size_slice = Slice(UInt8).new(4)

        # Make sure that this is actually an ID3 Tag
        @source.read id_slice
        raise "Not ID3" unless id_slice.to_a == ID3_IDENTIFIER

        # Header Structure (10bytes)
        # [ID3][M][m][F][SSSS]
        # M: Major Version
        # m: Minor Version
        # F: Flags
        # S: Size
        @major_version = @source.read_byte.as UInt8
        @minor_version = @source.read_byte.as UInt8
        @flag = @source.read_byte.as UInt8
        @unsynchronisation = ((@flag & 0b1000000) > 0)
        @extended_header = ((@flag & 0b0100000) > 0)
        @experimental = ((@flag & 0b0010000) > 0)
        @footer = ((@flag & 0b0001000) > 0)
        @source.read size_slice
        @size = ID3.synchsafe_decode(size_slice)
      end
    end
  end
end
