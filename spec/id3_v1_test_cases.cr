module ID3
  module TestSuiteValues
    V1_CASES = [
      # Case 1
      {
        :title   => "Title",
        :artist  => "Artist",
        :album   => "Album",
        :year    => 2003,
        :comment => "Comment",
        :genre   => ID3::V1::Genre::HipHop,
        :track   => nil,
        :file    => "id3v1_001_basic.mp3",
      },
      # Case 2
      {
        :title   => "Title",
        :artist  => "Artist",
        :album   => "Album",
        :year    => 2003,
        :comment => "Comment",
        :track   => 12,
        :genre   => ID3::V1::Genre::HipHop,
        :file    => "id3v1_002_basic.mp3",
      },
      # Case 3
      {
        :title   => "",
        :artist  => "",
        :album   => "",
        :year    => 2003,
        :comment => "",
        :genre   => ID3::V1::Genre::Blues,
        :track   => nil,
        :file    => "id3v1_003_basic_F.mp3",
      },
      # Case 4
      {
        :title   => "",
        :artist  => "",
        :album   => "",
        :year    => 2003,
        :comment => "",
        :genre   => ID3::V1::Genre::Blues,
        :track   => nil,
        :file    => "id3v1_004_basic.mp3",
      },
      # Case 5
      {
        :title   => "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaA",
        :artist  => "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbB",
        :album   => "cccccccccccccccccccccccccccccC",
        :year    => 2003,
        :comment => "dddddddddddddddddddddddddddddD",
        :genre   => ID3::V1::Genre::Blues,
        :track   => nil,
        :file    => "id3v1_005_basic.mp3",
      },
      # Case 6
      {
        :title   => "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaA",
        :artist  => "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbB",
        :album   => "cccccccccccccccccccccccccccccC",
        :year    => 2003,
        :comment => "dddddddddddddddddddddddddddD",
        :genre   => ID3::V1::Genre::Blues,
        :track   => 1,
        :file    => "id3v1_006_basic.mp3",
      },
      # Case 7
      {
        :title   => "12345",
        :artist  => "12345",
        :album   => "12345",
        :year    => 2003,
        :comment => "12345",
        :genre   => ID3::V1::Genre::Blues,
        :file    => "id3v1_007_basic_W.mp3",
        :track   => nil,
      },
      # Case 8
      {
        :title   => "12345",
        :artist  => "12345",
        :album   => "12345",
        :year    => 2003,
        :comment => "12345",
        :track   => 1,
        :genre   => ID3::V1::Genre::Blues,
        :file    => "id3v1_008_basic_W.mp3",
        :track   => 1,
      },
      # Case 9
      {
        :title   => "",
        :artist  => "",
        :album   => "",
        :year    => 2003,
        :comment => "",
        :track   => 255,
        :genre   => ID3::V1::Genre::Blues,
        :file    => "id3v1_009_basic.mp3",
      },
      # Case 10
      {
        :title   => "",
        :artist  => "",
        :album   => "",
        :year    => 0,
        :comment => "",
        :genre   => ID3::V1::Genre::Blues,
        :file    => "id3v1_010_year.mp3",
        :track   => nil,
      },
    ]
  end
end
