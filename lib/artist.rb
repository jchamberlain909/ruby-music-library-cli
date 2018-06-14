class Artist
    extend Concerns::Findable
    @@all = []

    attr_accessor :name, :songs
    def initialize name
        @name = name
        @songs = []
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
    def self.create(name)
        created = self.new(name)
        @@all << created 
        created    
    end

    def add_song song
        song.artist=self if song.artist == nil
        self.songs << song if !self.songs.include?(song)
    end 

    def genres
        self.songs.map {|song| song.genre}.uniq
    end
end