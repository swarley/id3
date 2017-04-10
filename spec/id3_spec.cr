require "./spec_helper"
require "./id3_v1_test_cases"

def case_file(hash : Hash(Symbol, String | Int32 | Nil | ID3::V1::Genre)) : File
  return File.open("etc/id3v1/" + hash[:file].as(String))
end

describe ID3::V1 do
  cases = ID3::TestSuiteValues::V1_CASES
  # Test case 1 -- plausible values
  it "reads a general tag" do
    test = cases.shift
    tag = ID3::V1::Tag.new(case_file(test))
    test.delete :file

    fail "Case 1 Fail" unless tag == test
  end

  # Test case 2 -- ID3v1.1 plausible values
  it "reads general ID3v1.1 tags" do
    test = cases.shift
    tag = ID3::V1::Tag.new(case_file(test))
    test.delete :file

    fail "Case 2 Fail" unless tag == test
  end

  # Test case 3 -- 'tag' instead of 'TAG'
  it "should fail for an incorrect tag" do
    test = cases.shift
    begin
      tag = ID3::V1::Tag.new(case_file(test))
      fail "Should have failed 'tag'"
    rescue Exception
    end
  end

  # Test case 4 -- smallest legal values
  it "allows for null values" do
    test = cases.shift
    tag = ID3::V1::Tag.new(case_file(test))
    test.delete :file

    fail "Values incorrectly represented" unless tag == test
  end

  # Test case 5 -- maximum value allowable
  it "captures the maximum value of each field" do
    test = cases.shift
    tag = ID3::V1::Tag.new(case_file(test))
    test.delete :file

    fail "Values incorrectly parsed" unless tag == test
  end

  # Test case 6 -- maximum value ID3v1.1
  it "captures the max values correctly for ID3v1.1" do
    test = cases.shift
    tag = ID3::V1::Tag.new(case_file(test))
    test.delete :file

    fail "Values incorrectly parsed" unless tag == test
  end

  # Test case 7 -- string terminator
  it "gets strings until the null terminator" do
    test = cases.shift
    tag = ID3::V1::Tag.new(case_file(test))
    test.delete :file

    fail "Values incorrectly parsed" unless tag == test
  end

  # Test case 8 -- terminator ID3v1.1
  it "null terminator ID3v1.1" do
    test = cases.shift
    tag = ID3::V1::Tag.new(case_file(test))
    test.delete :file

    fail "Values incorrectly parsed" unless tag == test
  end

  # Test case 9 -- max track number
  it "reads tags with a max track number" do
    test = cases.shift
    tag = ID3::V1::Tag.new(case_file(test))
    test.delete :file

    fail "Track number is wrong somehow" unless tag == test
  end

  # Test case 10
  it "parses the year correctly" do
    test = cases.shift
    tag = ID3::V1::Tag.new(case_file(test))
    test.delete :file

    fail "Year is wrong somehow" unless tag == test
  end
end

# describe ID3 do
#   # TODO: Write tests
#   mp3_file = File.open("etc/energy.mp3")

#   it "parses headers" do
#     tag = ID3::V2::TagHeader.new(mp3_file)
#     fail "Header version read incorrectly" unless tag.major_version == 4
#     fail "Header size read incorrectly" unless tag.size == 1167
#   end
# end
