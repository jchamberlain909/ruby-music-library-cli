class MusicLibraryController
    attr_accessor :path
    def initialize (path='./db/mp3s')
        MusicImporter.new(path).import
    end

    def call
        user_command=""
        while user_command.downcase !='exit'
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            user_command = gets.chomp
            case user_command
                when 'list songs'
                    self.list_songs
                when 'list artists'
                    self.list_artists
                when 'list genres'
                    self.list_genres
                when 'list artist'
                    self.list_songs_by_artist
                when 'list genre'
                    self.list_songs_by_genre
                when 'play song'
                    self.play_song
            end 
        end
    end

    def list_songs
        Song.all.sort{|a,b| a.name <=> b.name} .each_with_index {|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
        
    end
    def list_artists
        Artist.all.sort{|a,b| a.name <=> b.name} .each_with_index {|artist, i| puts "#{i+1}. #{artist.name}"}
    end
    def list_genres
        Genre.all.sort{|a,b| a.name <=> b.name} .each_with_index {|genre, i| puts "#{i+1}. #{genre.name}"}
    end
    def list_songs_by_artist
        puts("Please enter the name of an artist:")
        user_artist_query = gets.chomp
        artist = Artist.find_by_name(user_artist_query)
        if(artist!=nil)
            artist.songs.sort{|a,b| a.name <=> b.name} .each_with_index {|song, i| puts "#{i+1}. #{song.name} - #{song.genre.name}"}
        end
    end 
    def list_songs_by_genre
        puts("Please enter the name of a genre:")
        user_genre_query = gets.chomp
        genre = Genre.find_by_name(user_genre_query)
        if(genre!=nil)
            genre.songs.sort{|a,b| a.name <=> b.name} .each_with_index {|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name}"}
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        user_song_selection = gets.chomp
        if(user_song_selection.to_i.between?(1,5))
            song = Song.all.sort{|a,b| a.name <=> b.name}[user_song_selection.to_i-1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end
end