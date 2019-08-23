class MusicLibraryController

    def initialize(path = "./db/mp3s")
        @song_list = []
        MusicImporter.new(path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = gets.strip
        case input
        when "list songs"
            list_songs
        when "list artists"
            list_artists
        when "list genres"
            list_genres
        when "list artist"
            list_songs_by_artist
        when "list genre"
            list_songs_by_genre
        when "play song"
            play_song
        when "exit"
        else
            call
        end
    end

    def sorted_songs
        Song.all.sort{|a, b| a.name <=> b.name}
    end

    def list_songs
        sorted_songs.each_with_index{|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end

    def list_artists
        artists = Artist.all.map{|artist| artist.name}
        sorted_artists = artists.sort
        sorted_artists.each_with_index{|artist, index| puts "#{index + 1}. #{artist}"}
        sorted_artists
    end

    def list_genres
        genres = Genre.all.map{|genre| genre.name}
        sorted_genres = genres.sort
        sorted_genres.each_with_index{|genre, index| puts "#{index + 1}. #{genre}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        found_artist = Artist.all.find{|artist| artist.name == input}
        if found_artist
            sorted_songs = found_artist.songs.sort{|a, b| a.name <=> b.name}
            sorted_songs.each_with_index{|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        found_genre = Genre.all.find{|genre| genre.name == input}
        if found_genre
            sorted_genres = found_genre.songs.sort{|a, b|  a.name <=> b.name}
            sorted_genres.each_with_index{|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        selected_song = sorted_songs.find.with_index{|song, index| input == index + 1}
        puts "Playing #{selected_song.name} by #{selected_song.artist.name}" unless !selected_song
    end
end