class MusicImporter
    attr_accessor :path
    def initialize path
        @path = path
    end

    def files
        Dir["#{self.path}/*"].map {|file_path| file_path.split('/').last}
    end

    def import
       self.files.map {|path| Song.create_from_filename(path)}
    end 

end