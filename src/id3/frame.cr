module ID3
  class Frame
    @source : IO::Memory

    def initialize(@header : V2TagHeader, @location : Int = 0)
      @source = @header.source.dup
      @id_slice = Bytes.new 4

      if @location
        @location = @header.frames_start
      end

      @source.seek @location
      @source.read @id_slice
      puts @id_slice.to_a.map { |x| x.chr }.join
    end
  end
end
