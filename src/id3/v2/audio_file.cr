require "../error"
require "./synchsafe"

module ID3
  module V2
    class AudioFile < File
      alias HeaderTuple = NamedTuple(major_version: UInt8, minor_version: UInt8, flags: UInt8, size: ID3::V2::Synchsafe)
      @header : HeaderTuple | Nil

      macro test_header_nilness(var)
        if {{var}}.nil?
          raise ID3::Error::DecodingError.new "Unable to get #{ {{var}} } from tag header"
        end
      end

      macro flag_method(name, bit)
        def {{name}}? : Bool
          return @header[:flags].bit({{bit}}) == 1
        end
      end

      def finalize
        read_at(0, 3) do |io|
          id = io.gets

          if id.nil?
            raise ID3::Error::DecodingError.new "Could not get tag identifier"
          end

          if id != "ID3"
            raise ID3::Error::DecodingError.new "Invalid ID3v2 Tag ID: #{id}"
          end
        end
      end

      def header
        if @header.nil?
          # Not attempting to check for ID3v2ness since it's made redundant in AudioFile#finalize
          # io should hold -> [major_version, minor_version, flags, size_1, size_2, size_3, size_4]
          read_at(3, 7) do |io|
            major_version = io.read_byte
            minor_version = io.read_byte
            flags = io.read_byte
            size = [] of UInt8
            4.times do
              s = io.read_byte
              if s.nil?
                raise ID3::Error::DecodingError.new "Unable to get size byte"
              end

              size << s
            end

            test_header_nilness(major_version)
            test_header_nilness(minor_version)
            test_header_nilness(flags)

            @header = {
              major_version: major_version,
              minor_version: minor_version,
              flags:         flags,
              size:          ID3::V2::Synchsafe.new(size),
            }
          end
        else
          return @header.as(HeaderTuple)
        end
      end

      flag_method(unsychronisation, 7)
      flag_method(extended_header, 6)
      flag_method(extended_header, 5)
      flag_method(footer, 4)
    end
  end
end

file = ID3::V2::AudioFile.new("../../../etc/energy.mp3")
