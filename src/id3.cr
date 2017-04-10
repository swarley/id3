require "./id3/v1/*"
require "./id3/v2/*"

module ID3
  ID3_IDENTIFIER = [73, 68, 51]

  def self.read(str : String)
    file = File.open str
    if is_v1? file
      raise "V1 not supported yet"
    elsif is_v2? file
      ID3::V2::File.new(file)
    end
  end

  def is_v1?(file : File)
    last_pos = file.pos
    file.seek -128
    tag = file.gets 3
    file.pos = last_pos

    if tag == "TAG"
      return true
    else
      return false
    end
  end

  def is_v2?(file : File)
    id_slice = Bytes.new(3)
    last_pos = file.pos
    file.seek 0
    tag = file.gets 3
    file.pos = last_pos

    if tag == "ID3"
      return true
    else
      return false
    end
  end
end
