require "./spec_helper"

describe ID3 do
  # TODO: Write tests
  mp3_file = IO::Memory.new(File.read("etc/energy.mp3"))

  it "parses headers" do
    tag = ID3::V2TagHeader.new(mp3_file)
    fail "Header version read incorrectly" unless tag.major_version == 4
    fail "Header size read incorrectly" unless tag.size == 1167
  end

  it "reads headers" do
    tag = ID3::V2TagHeader.new(mp3_file)
    frame = ID3::Frame.new(tag)
  end
end
