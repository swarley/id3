require "./synchsafe"
require "./header"
require "./frame_header"
require "./frames/*"

module ID3
  module V2
    class FrameParser
      getter :frames

      def initialize(source : File, @frame_start : Int32)
        @frames = [] of BasicFrame
        @source = source.dup.as File
        @source.seek @frame_start
        @end_reached = false
      end

      def get_frames
        until @end_reached
          get_frame
        end
      end

      def get_frame
        begin
          header = FrameHeader.new(@source)
        rescue e
          puts e
          @end_reached = true
          puts "reached end"
          return
        end

        frame_type = TextFrame
        case header.id
        when "COMM"
          frame_type = CommentsFrame
        when "COMR"
          frame_type = CommericalFrame
        when "TXXX"
          frame_type = UserTextFrame
        when /^T/
          frame_type = TextFrame
        else
          puts @source.gets(header.size)
          puts "Only text frames implemented"
        end
        if frame_type != nil
          @frames.push frame_type.new(header)
        end
      end

      def frames
        p @frames
      end
    end
  end
end
