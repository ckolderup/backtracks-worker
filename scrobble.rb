module Scrobble
  def chart_v1(username)
    fetch = Fetch.new

    @years = (1..3).map do |y|
      (artists, albums, tracks) = fetch.get_charts(:user => username,
                          :years_ago => y,
                          :chart_size => 15)

      {
        num: y,
        plural: (y == 1)? "" : "s",
        album_rows: albums.each_slice(5).map { |row| { albums: row } }
      }
    end

    mustache(:email)
  end
end

