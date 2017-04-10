module ID3
  module V1
    class NoTag < Exception
    end

    class DecodingError < Exception
    end

    class UnknownGenre < DecodingError
    end
  end
end
