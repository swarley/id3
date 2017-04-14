require "../int_helper"

module ID3
  module V2
    class FrameHeader
      @access_mode : Bool
      @encryption : Bool
      @compression : Bool
      @grouping_identity : Bool
      @flags : Array(UInt8)
      @file_alter_preservation : Symbol
      @tag_alter_preservation : Symbol
      getter :id, :size, :flags, :source, :index
      getter :file_alter_preservation, :tag_alter_preservation
      getter :access_mode, :grouping_identity, :encryption, :compression

      def initialize(@source : File)
        @id = @source.gets(4).as String
        puts @id
        raise "Invalid frame id" unless @id =~ /[A-Z0-9]{4}/
        @size = ID3::V2.get_synchsafe(@source.gets(4).as(String).bytes)
        @flags = @source.gets(2).as(String).bytes
        @access_mode = @flags[0].bit_set? 5
        @file_alter_preservation = @flags[0].bit_set?(6) ? :discard : :preserve
        @tag_alter_preservation = @flags[0].bit_set?(7) ? :discard : :preserve
        @grouping_identity = @flags[1].bit_set? 5
        @encryption = @flags[1].bit_set? 6
        @compression = @flags[1].bit_set? 7
      end
    end
  end
end
