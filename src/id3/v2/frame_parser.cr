require "./synchsafe"
require "./header"
require "./frame_header"
require "./frames/*"

module ID3
  module V2
    class FrameParser
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

        case header.id
        when /^T/
          @frames.push TextFrame.new(header)
        else
          @source.gets(header.size)
          puts "Only text frames implemented"
        end
      end

      def frames
        p @frames
      end
    end
  end
end

file = File.open "../../../etc/energy.mp3"
head = ID3::V2::Header.new file
parser = ID3::V2::FrameParser.new file, 10
parser.get_frames
parser.frames
