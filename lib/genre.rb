class Genre

  extend Concerns::Findable

  attr_accessor :name

  attr_reader :songs

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name=name
    @songs=[]
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new_genre=self.new(name)
    new_genre.save
    new_genre
  end

  def self.destroy_all
    self.all.clear
  end

  #Used attr_reader instead
  #def songs
    #@songs
  #end

  def add_song(song)
    song.genre = self unless song.genre
    @songs << song unless @songs.include?(song)
  end

  def artists
    #Code works but is longer but also makes more sense
    artist_array=[]
    @songs.each do |song|
      artist_array<<song.artist unless artist_array.include?(song.artist)
    end
    artist_array

    #The following line of code also works.
    #I don't know if it's better but
    #it's shorter than the above 5 lines.
    #and doesn't require creating a local variable
    #to temporarily store the artist array

    #@songs.collect{|song|song.artist}.uniq

  end

end
