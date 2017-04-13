require "../error"
require "./genre"

module ID3
  module V1
    class Tag
      @title : String | Nil
      @artist : String | Nil
      @album : String | Nil
      @year : Int32 | Nil
      @comment : String | Nil
      @genre : Genre | Nil
      @track : UInt8 | Nil

      def initialize(source : File)
        @source = source.dup.as File
        @source.skip_to_end
        @source.pos -= 128
        tag = @source.gets 3

        raise Error::NoTag.new unless tag == "TAG"

        get_info

        # Specific error for out of bounds genre
        if @genre.nil?
          raise Error::DecodingError.new "Unknown Genre"
        end

        [@title, @artist, @album, @year, @comment].each do |v|
          raise Error::DecodingError.new "Tag size too small. Reached EOF" if v.nil?
        end
      end

      def get_info
        get_id
        get_title
        get_artist
        get_album
        get_year
        get_comment
        get_genre
      end

      def get_id
        @source.skip_to_end
        @source.pos -= 128
        id = @source.gets 3

        if id != "TAG"
          raise Error::DecodingError.new("Invalid ID3v1 tag identifier")
        end
      end

      def get_title
        @source.skip_to_end
        @source.pos -= 125
        title = @source.gets 30

        if title.nil?
          @title = ""
          raise Error::DecodingError.new("File too small. EOF Reached on Title")
        end

        # Get all data until null (As per the standard)
        @title = get_str(title)
      end

      def get_artist
        @source.skip_to_end
        @source.pos -= 95
        artist = @source.gets 30

        if artist.nil?
          @artist = ""
          raise Error::DecodingError.new("File too small. EOF Reached on Artist")
        end

        @artist = get_str(artist)
      end

      def get_album
        @source.skip_to_end
        @source.pos -= 65
        album = @source.gets 30

        if album.nil?
          @album = ""
          raise Error::DecodingError.new("File too small. EOF Reached on Album")
        end
        @album = get_str(album)
      end

      def get_year
        @source.skip_to_end
        @source.pos -= 35
        year = @source.gets 4

        if year.nil?
          @year = 0
          raise Error::DecodingError.new("File too small. EOF Reached on Year")
        end

        @year = year.as(String).to_i
      end

      def get_comment
        @source.skip_to_end
        @source.pos -= 31
        comment = @source.gets 29
        track = @source.read_byte.as(UInt8)

        if comment.nil?
          @comment = ""
          @track = nil
          raise Error::DecodingError.new("File too small. EOF Reached on Comment")
        end

        if comment.char_at(-1) == '\0' && track != 0
          @track = track.as(UInt8)
          comment = comment[0..-2]
        else
          comment += track.chr
          @track = nil
        end
        @comment = get_str(comment)
      end

      def get_genre
        @source.skip_to_end
        @source.pos -= 1
        genre = @source.gets(1)
        if genre.nil?
          @genre = nil
          return
        end

        @genre = Genre.new(genre[0].ord)
      end

      def get_str(str)
        str_term = str.index '\0'

        if str_term.nil?
          return str
        else
          return str[0, str_term]
        end
      end

      def to_h
        return {:title => @title, :artist => @artist, :album => @album, :year => @year, :comment => @comment, :genre => @genre, :track => @track}
      end

      def ==(h : Hash(Symbol, String | Int32 | UInt8 | Nil | ID3::V1::Genre)) : Bool
        return to_h == h
      end
    end
  end
end
