require "./synchsafe"
require "./error"
require "./helper"

module ID3
  class V2TagHeader
    @unsynchronised : Bool
    @experimental : Bool
    @extended_header : Bool
    @footer : Bool
    getter :major_version, :minor_version, :size
    getter :unsynchronised, :extended_header, :experimental, :footer
    getter :source

    def initialize(buff : IO::Memory)
      @source = buff
      @bytes = Bytes.new 10
      @source.seek 0
      @source.read @bytes

      # Check bytes 1-3/10 for ['I','D','3']
      unless is_tag?
        raise NoTag.new
      end

      # Major 4/10
      # Minor 5/10
      @major_version = @bytes[3].as UInt8
      @minor_version = @bytes[4].as UInt8

      # Flag Information Resides in 6/10
      # [unsync, extended, experimental, footer, nil, nil, nil]
      @unsynchronised = bit_set? 7
      @extended_header = bit_set? 6
      @experimental = bit_set? 5
      @footer = bit_set? 4

      # Tag Size 7-10/10
      sz_byte = @bytes[6, 4]
      @size = ID3.synchsafe_decode(ID3.get_synchsafe(@bytes[6, 4]))
    end

    def frames_start
      i = 10

      if @extended_header
        i += ID3.extended_header_size(@source)
      end

      return i
    end

    # Check the bits from the flag byte
    def bit_set?(bit_n : Int) : Bool
      @bytes[5].bit(bit_n) == 1
    end

    # Test the first 3 bytes for the identifier
    private def is_tag? : Bool
      @bytes[0, 3].to_a.map { |x| x.chr }.join == "ID3"
    end
  end
end
