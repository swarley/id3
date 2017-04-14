module ID3
  module V2
    # Reconstruct a synchsafe integer
    def self.get_synchsafe(bytes : Array(UInt8)) : Int32
      ret = 0
      bytes.each_with_index do |byte, index|
        ret |= byte << (7 * (bytes.size - (index + 1)))
      end

      return ret
    end

    def self.synchsafe_encode(int : Int32)
      i = int
      mask = 0x7f

      while mask <= 0x7fffffff
        ret = i & ~mask
        ret = ret << 1
        ret |= (i & mask)
        mask = ((mask + 1) << 8) - 1
        i = ret
      end

      return ret
    end

    def self.synchsafe_decode(ss_int : Int32) : Int32
      ret = 0
      mask = 0x7F000000

      while mask > 0
        ret = ret >> 1
        ret |= (ss_int & mask)
        mask = mask >> 8
      end

      return ret
    end
  end
end
