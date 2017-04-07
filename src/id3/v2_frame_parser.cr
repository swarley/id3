module ID3
  module V2
    class FrameParser
      def initialize(@source : File)
        @frames = [] of V2Frame
      end
    end
  end
end
