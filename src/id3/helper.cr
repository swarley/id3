module ID3
  # Reconstruct a synchsafe integer
  # Synchsafe ints are split into multiple bytes and I can't figure out a better way
  # to convert the bytes to a single int
  def self.get_synchsafe(slice : Slice(UInt8)) : Int32
    String.build do |str|
      slice.to_a.map { |s| s.to_s 16 }.each do |s|
        if s.size == 1
          str << ('0' + s)
        else
          str << s
        end
      end
    end.to_i 16
  end

  # TODO: UPDATE THIS TO ACTUALLY WORK, STILL NEED AN EXAMPLE FILE
  def self.extended_header_size(source : IO::Memory) : Int32
    raise "Please submit this file to me on github so that it can be used to properly develop this function"
    return 1
  end
end
