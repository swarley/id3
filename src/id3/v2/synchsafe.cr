module ID3
  module V2
    # Reconstruct a synchsafe integer
    # Synchsafe ints are split into multiple bytes and I can't figure out a better way
    # to convert the bytes to a single int
    def self.get_synchsafe(bytes : Array(UInt8)) : Int32
      ss = 0_i32
      temp = bytes
      p temp.map { |x| x.to_s 2 }
      bytes.each do |byte|
        ss <<= 7
        ss += byte
      end

      return ss
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
