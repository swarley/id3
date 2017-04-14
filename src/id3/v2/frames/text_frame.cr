module ID3
  module V2
    class TextFrame < BasicFrame
      def format_data
        determine_name

        enc = get_byte
        if enc == 0
          @encoding = "ISO-8859-1"
        else
          @encoding = "UTF-8"
        end

        bytes = Bytes.new(size - 1)
        @header.source.read bytes

        @data = String.new(bytes, @encoding.as(String))
      end

      def determine_name
        @name = case @header.id
                when "TALB"
                  "Album/Movie/Show title"
                when "TBPM"
                  "Beats Per Minute"
                when "TCOM"
                  "Composer"
                when "TCON"
                  "Content Type"
                when "TCOP"
                  "Copyright Message"
                when "TDAT"
                  "Date"
                when "TDLY"
                  "Playlist Delay"
                when "TDRC"
                  "Recording time"
                when "TDRL"
                  "Release time"
                when "TENC"
                  "Encoded by"
                when "TEXT"
                  "Lyricist/Text Writer"
                when "TFLT"
                  "File Type"
                when "TIME"
                  "Time"
                when "TIT1"
                  "Content group description"
                when "TIT2"
                  "Title/songname/content description"
                when "TIT3"
                  "Subtitle Description Refinement"
                when "TKEY"
                  "Initial Key"
                when "TLAN"
                  "Languages"
                when "TLEN"
                  "Lenght"
                when "TMED"
                  "Media Type"
                when "TOAL"
                  "Original album/movie/show title"
                when "TOFN"
                  "Original file name"
                when "TOLY"
                  "Original lyricists/text writers"
                when "TOPE"
                  "Original artists/performers"
                when "TORY"
                  "Original release year"
                when "TOWN"
                  "File owner/licensee"
                when "TPE1"
                  "Lead performers/Soloists"
                when "TPE2"
                  "Band/orchestra/accompaniment"
                when "TPE3"
                  "Conductor/performer refinement"
                when "TPE4"
                  "Interpreted, remixed, or otherwise modified by"
                when "TPOS"
                  "Part of a set"
                when "TPUB"
                  "Publisher"
                when "TRCK"
                  "Track number"
                when "TRDA"
                  "Recording dates"
                when "TRSN"
                  "Internet Radio Station Name"
                when "TRSO"
                  "Internet Radio Station Owner"
                when "TSIZ"
                  "Size"
                when "TSRC"
                  "ISRC"
                when "TSSE"
                  "Software/Hardware and settings used for encoding"
                when "TYER"
                  "Year"
                when "TXXX"
                  "User defined text information frame"
                else
                  raise "Unknown frame id: #{@header.id}"
                end
      end
    end
  end
end
