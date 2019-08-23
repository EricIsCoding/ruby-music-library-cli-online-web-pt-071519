class Genre
    attr_accessor :name, :songs

    extend Concerns::Findable

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.create(name)
        instance = self.new(name)
        instance.save
        instance
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def add_song(song)
        songs << song if !songs.include?(song)
        song.genre = self unless song.genre
    end

    def artists
        songs.collect{|song| song.artist}.uniq
    end
end