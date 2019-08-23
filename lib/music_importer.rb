class MusicImporter
    attr_accessor :path

    def initialize(file_path)
        @path = file_path
    end

    def files
        Dir.entries(path).select{|path| path.match(".mp3")}
    end

    def import
        files.each{|filename| Song.create_from_filename(filename)}
    end
end