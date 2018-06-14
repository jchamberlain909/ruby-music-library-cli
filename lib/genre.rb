class Genre
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
        self.songs << song if !self.songs.include?(song)
    end 
    def artists 
        self.songs.map {|song| song.artist}.uniq
    end
        
end