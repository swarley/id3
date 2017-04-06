module ID3
  def self.synchsafe_encode(bytes : Array(UInt8))
    i = bytes.join.to_i(16)
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
