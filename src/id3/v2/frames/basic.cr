module ID3
  module V2
    class BasicFrame
      @data : String | Nil
      getter :header

      def initialize(@header : FrameHeader)
        @data = nil
        format_data
      end

      def format_data
      end

      def access_mode : Bool
        @header.access_mode
      end

      def grouping_identity : Bool
        @header.grouping_identity
      end

      def encryption : Bool
        @header.encryption
      end

      def compression : Bool
        @header.compression
      end

      def file_alter_perservation : Symbol
        @header.file_alter_perservation
      end

      def tag_alter_preservation : Symbol
        @header.tag_alter_preservation
      end

      def size : Int
        @header.size
      end

      def gets(int : Int) : String
        return @header.source.gets(int).as String
      end

      def gets(str : String) : String
        return @header.source.gets(str).as String
      end

      def get_encoding
        i = get_byte

        if i == 0
          @encoding = "ISO-8859-1"
        else
          @encoding = "UTF-8"
        end
      end

      def get_byte : UInt8
        return @header.source.read_byte.as UInt8
      end

      def get_to_null_iso : String
        return @header.source.gets('\0', @header.size).as String
      end

      def get_to_null_utf8 : String
        return @header.source.gets("\0\0", @header.size).as String
      end

      def get_to_null : String
        if @encoding == "UTF-8"
          get_to_null_utf8
        else
          get_to_null_iso
        end
      end

      def get_data : String
        return @header.source.gets(@header.size)
      end
    end
  end
end

# module ID3
#   module V2
#     def self.frame_id_description(id : String)
#       case id
#       when "AENC"
#         "Audio Encryption"
#       when "APIC"
#         "Attached Picture"
#       when "ASPI"
#         "Audio Seek Point Index"
#       when "COMM"
#         "Comments"
#       when "COMR"
#         "Comercial Frame"
#       when "ENCR"
#         "Encryption Method Registration"
#       when "EQU2"
#         "Equalisation"
#       when "ETCO"
#         "Event Timing Codes"
#       when "GEOB"
#         "General Encapsulated Object"
#       when "GRID"
#         "Group Identification Registration"
#       when "LINK"
#         "Linked Inforamtion"
#       when "MCDI"
#         "Music CD Identifier"
#       when "MLLT"
#         "MPEG Location Lookup Table"
#       when "OWNE"
#         "Ownership Frame"
#       when "PRIV"
#         "Private Frame"
#       when "PCNT"
#         "Play Counter"
#       when "POPM"
#         "Popularimeter"
#       when "POSS"
#         "Position Synchronisation Frame"
#       when "RBUF"
#         "Recommended Buffer Size"
#       when "RVA2"
#         "Relative Volume Adjustment"
#       when "RVRB"
#         "Reverb"
#       when "SEEK"
#         "Seek Frame"
#       when "SIGN"
#         "Signature Frame"
#       when "SYLT"
#         "Synchronised Lyric/Text"
#       when "SYTC"
#         "Synchronised Tempo Codes"
#       when "UFID"
#         "Unique File Identifier"
#       when "USER"
#         "Terms of Use"
#       when "USLT"
#         "Unsychronised Lyric/Text Transcription"
#       when "WCOM"
#         "Commercial Information"
#       when "WCOP"
#         "Copyright/Legal Information"
#       when "WOAF"
#         "Official Audio File Webpage"
#       when "WOAR"
#         "Official Artist/Performer Webpage"
#       when "WOAS"
#         "Official Audio Source Webpage"
#       when "WORS"
#         "Official Internet Radio Station Homepage"
#       when "WPAY"
#         "Payment"
#       when "WPUB"
#         "Publisher's Official Webpage"
#       when "WXXX"
#         "User Defined URL Link Frame"
#       when "TALB"
#         "Album/Movie/Show title"
#       when "TBPM"
#         "Beats Per Minute"
#       when "TCOM"
#         "Composer"
#       when "TCON"
#         "Content Type"
#       when "TCOP"
#         "Copyright Message"
#       when "TDAT"
#         "Date"
#       when "TDLY"
#         "Playlist Delay"
#       when "TDRC"
#         "Recording Time"
#       when "TDRL"
#         "Release Time"
#       when "TENC"
#         "Encoded by"
#       when "TEXT"
#         "Lyricist/Text Writer"
#       when "TFLT"
#         "File Type"
#       when "TIME"
#         "Time"
#       when "TIT1"
#         "Content Group Description"
#       when "TIT2"
#         "Title/Songname/Content Description"
#       when "TIT3"
#         "Subtitle Description Refinement"
#       when "TKEY"
#         "Initial Key"
#       when "TLAN"
#         "Languages"
#       when "TLEN"
#         "Lenght"
#       when "TMED"
#         "Media Type"
#       when "TOAL"
#         "Original Album/Movie/Show Title"
#       when "TOFN"
#         "Original File Name"
#       when "TOLY"
#         "Original Lyricists/Text Writers"
#       when "TOPE"
#         "Original Artists/Performers"
#       when "TORY"
#         "Original Release Year"
#       when "TOWN"
#         "File Owner/Licensee"
#       when "TPE1"
#         "Lead Performers/Soloists"
#       when "TPE2"
#         "Band/Orchestra/Accompaniment"
#       when "TPE3"
#         "Conductor/Performer Refinement"
#       when "TPE4"
#         "Interpreted, remixed, or otherwise modified by"
#       when "TPOS"
#         "Part of a set"
#       when "TPUB"
#         "Publisher"
#       when "TRCK"
#         "Track number"
#       when "TRDA"
#         "Recording dates"
#       when "TRSN"
#         "Internet Radio Station Name"
#       when "TRSO"
#         "Internet Radio Station Owner"
#       when "TSIZ"
#         "Size"
#       when "TSRC"
#         "ISRC"
#       when "TSSE"
#         "Software/Hardware and settings used for encoding"
#       when "TYER"
#         "Year"
#       when "TXXX"
#         "User Defined Text Information Frame"
#       else
#         ""
#       end
#     end
#   end
# end
