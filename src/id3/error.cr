module ID3
  module Error
    class NoTag < Exception
    end

    class DecodingError < Exception
    end

    class UnknownGenre < DecodingError
    end
  end
end
