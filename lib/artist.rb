class Artist

  extend Concerns::Findable

  attr_accessor :name

  attr_reader :songs

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name=name
    @songs = []
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new_artist=self.new(name)
    new_artist.save
    new_artist
  end

  def self.destroy_all
    self.all.clear
  end

  #Used attr_reader instead
  #def songs
    #@songs
  #end

  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless @songs.include?(song)

  end

  def genres
    #Code works but is longer but also makes more sense
    genre_array=[]
    @songs.each do |song|
      genre_array<<song.genre unless genre_array.include?(song.genre)
    end
    genre_array

    #The following line of code also works.
    #I don't know if it's better but
    #it's shorter than the above 5 lines.
    #and doesn't require creating a local variable
    #to temporarily store the genre array
    
    #@songs.collect{|song|song.genre}.uniq

  end

end
