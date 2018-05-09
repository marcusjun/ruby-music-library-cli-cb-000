class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def self.all
    @@all
  end

  def initialize(name,artist=nil,genre=nil)
    @name=name

    self.send("artist=",artist) if artist!=nil
    self.send("genre=",genre) if genre!=nil

    ##############################################
    #Code that didn't work
    #@artist=artist if artist!=nil
    #@artist=artist
    #artist=(artist)
    #self.instance.artist=(artist)
    #self.artist=artist

    #@genre=genre
    #genre.add_song(self)
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    #new_song=self.new(name)
    #new_song.save
    #new_song

    self.new(name).save.tap# do |o|
      #o.name=name
    #end

  end

  def self.destroy_all
    self.all.clear
  end

  def artist=(artist)
    @artist=artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre=genre
    genre.add_song(self)
  end

  def self.find_by_name(name)
    self.all.detect {|song| song.name==name}
  end

  def self.find_or_create_by_name(name)
    #ternary
    (self.find_by_name(name) ? self.find_by_name(name) : self.create(name))
  end

  def self.new_from_filename(filename)
    split_file=filename.split(" - ")
    artist_name=split_file[0]
    song_name=split_file[1]
    genre_name=split_file[2].gsub(".mp3","")

    new_song=Song.new(song_name)
    new_song.artist=Artist.find_or_create_by_name(artist_name)
    new_song.genre=Genre.find_or_create_by_name(genre_name)
    new_song

    ###########################################
    #The following lines of code didn't work because
    #they created new instances of Artist or Genre
    #without checkig if the artist or genre already exist.

    #new_song.artist=Artist.new(split_artist_name)
    #new_song.genre=Genre.new(split_genre_name)
  end

  def self.create_from_filename(filename)
    #Either line of code works
    #@@all<<self.new_from_filename(filename)
    self.new_from_filename(filename).save
  end



end
