require "./synchsafe"
require "../int_helper"

# require "../../id3"

module ID3
  module V2
    class Header
      # @size : Int32
      @unsynchronisation : Bool
      @extended_header : Bool
      @experimental : Bool
      @footer : Bool
      getter :major_version, :minor_version
      getter :flag
      getter :size
      getter :unsynchronisation, :extended_header, :experimental, :footer
      getter :source

      def initialize(@source : File)
        # ID3 Header is 10bytes, less than that is impossible
        raise "File too short to be ID3" if @source.size < 10
        @source.seek 0
        # Create slices for IO#read(s : Slice(T))
        size_slice = Slice(UInt8).new(4)

        # Make sure that this is actually an ID3 Tag
        id = @source.gets(3)
        raise "Not ID3" unless id == "ID3"
        # Header Structure (10bytes)
        # [ID3][M][m][F][SSSS]
        # M: Major Version
        # m: Minor Version
        # F: Flags
        # S: Size
        @major_version = @source.read_byte.as UInt8
        @minor_version = @source.read_byte.as UInt8
        @flag = @source.read_byte.as UInt8
        @unsynchronisation = @flag.bit_set? 7
        @extended_header = @flag.bit_set? 6
        @experimental = @flag.bit_set? 5
        @footer = @flag.bit_set? 4
        size_str = @source.gets(4).as(String)
        @size = ID3::V2.get_synchsafe(size_str.bytes)
      end
    end
  end
end
