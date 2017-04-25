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

      return i
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

module ID3
  module V2
    class Synchsafe
      def initialize(i : Int32, @encoded : Bool? = true)
        @val = i
      end

      def initialize(bytes : Array(UInt8))
        @encoded = true
        p bytes
        @val = bytes_to_int(bytes)
      end

      def decode
        new_val = 0
        mask = 0x7F000000

        while mask > 0
          new_val >>= 1
          new_val |= (@val & mask)
          mask = mask >> 8
        end

        @val = new_val
      end

      def encode
        old_val = @val
        mask = 0x7F

        while mask <= 0x7FFFFFFF
          i = old_val & ~mask
          i <<= 1
          i |= (old_val & mask)
          mask = ((mask + 1) << 8) - 1
          old_val = i
        end

        return old_val
      end

      def inspect
        return @val.inspect
      end

      def to_i
        return @val
      end

      private def bytes_to_int(bytes : Array(UInt8)) : Int32
        int = 0_i32
        bytes.each_with_index do |byte, index|
          int |= byte.to_i32 << (7 * (bytes.size - (index + 1)))
        end

        return int
      end
    end
  end
end
