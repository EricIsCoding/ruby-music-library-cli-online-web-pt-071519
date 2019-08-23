require 'pry'

class Song
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist_name = nil,genre = nil)
        @name = name
        self.artist = artist_name
        self.genre = genre
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.find_by_name(name)
        @@all.find{|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(filename)
        split_file = filename.split(" - ")
        split_file.last.delete_suffix!(".mp3")
        new_song = new(split_file[1])
        new_artist = Artist.find_or_create_by_name(split_file[0])
        new_genre = Genre.find_or_create_by_name(split_file[2])
        new_song.artist = new_artist
        new_song.genre = new_genre
        new_song
    end

    def self.create_from_filename(filename)
        song = new_from_filename(filename)
        song.save
    end

    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist
        artist && artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre && genre.add_song(self)
    end
end