class Song
    extend Concerns::Findable
    @@all = []
    attr_accessor :name, :artist, :genre
    def initialize (name, artist=nil, genre=nil)
        @name = name
        self.artist= artist if !artist.nil?
        self.genre= genre if !genre.nil?
    end
    def self.all
        @@all
    end
    def save
        @@all << self
    end 
    def self.destroy_all
        @@all = []
    end  
    def self.create(name, artist=nil, genre=nil)
        created = self.new(name, artist, genre)
        @@all << created 
        created
    end
    def artist= artist
        @artist = artist        
        artist.add_song(self)
    end
    def genre= genre
        @genre = genre 
        genre.add_song self
    end

    def self.new_from_filename filename
        split_filename = filename.gsub('.mp3','').split(" - ")
        new_song = Song.find_or_create_by_name(split_filename[1])
        new_song.artist=Artist.find_or_create_by_name(split_filename[0])
        new_song.genre=Genre.find_or_create_by_name(split_filename[2])
        new_song
    end

    def self.create_from_filename filename
        new_song = self.new_from_filename filename
        new_song
    end
    
end