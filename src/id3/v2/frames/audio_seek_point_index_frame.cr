# I'M NOT SURE WHAT DATA THIS FRAME IS SUPPOSED TO HOLD??
require "./basic"

module ID3
  module V2
    class AudioSeekPointIndex < BasicFrame
      def format_data
        @data_start = gets(4).to_i(16).as Int32
        @data_length = gets(4).to_i(16).as Int32
        @point_count = gets(2).to_i(16).as Int32
        @bits_per_index = get_byte.as UInt8
      end
    end
  end
end
