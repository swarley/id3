module ID3
  module V2
    class Frame
      def initialize(@id : String, @size : Int, @flags : Array(UInt8))
      end

      def initialize(&block)
        yield
      end
    end
  end
end
