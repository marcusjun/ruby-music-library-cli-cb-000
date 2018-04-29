class MusicLibraryController

  attr_reader :path

  def initialize(path='./db/mp3s')
    @path=path

    MusicImporter.new(path).import

    #@new_music=MusicImporter.new(path)
    #@new_music.import
    #new_music=MusicImporter.new(path)
    #new_music.import

  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    #puts "What would you like to do?"

    #defining input as a string but an empty string
    input=""

    while input!="exit"
      puts "What would you like to do?"

      input=gets.strip

      #Case statements
      case input
      when "list songs" then list_songs
      when "list artists" then list_artists
      when "list genres" then list_genres
      when "list artist" then list_songs_by_artist
      when "list genre" then list_songs_by_genre
      when "play song" then play_song
      end

      ####################################
      #if/else statements
      #if input=="list songs"
        #list_songs
      #elsif input=="list artists"
        #list_artists
      #elsif input=="list genres"
        #list_genres
      #elsif input=="list artist"
        #list_songs_by_artist
      #elsif input=="list genre"
        #list_songs_by_genre
      #elsif input=="play song"
        #play_song
      #end
    end
  end

  def list_songs
    #Shorter version, doesn't require local variable,
    #may be more difficult to read and understand

    #In the Song class, get the all array, then sort by each
    #song's name, then iterate through the array and puts...

    Song.all.sort_by{|song| song.name}.each_with_index do |song,index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end

    ################################################
    #Long version works and is easier to understand
    #but requires creation of temp variable to store song array
    #song_array=Song.all
    #song_array.sort_by!{|song| song.name}
    #song_array.each_with_index do |song,index|
      #puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    #end

  end

  def list_artists

    #Short version
    Artist.all.sort_by{|artist| artist.name}.each_with_index do |artist,index|
      puts "#{index+1}. #{artist.name}"
    end

    #################################################
    #Long version
    #artist_array=Artist.all
    #artist_array.sort_by!{|artist| artist.name}
    #artist_array.each_with_index do |artist,index|
      #puts "#{index+1}. #{artist.name}"
    #end
  end

  def list_genres

    Genre.all.sort_by{|genre| genre.name}.each_with_index do |genre,index|
      puts "#{index+1}. #{genre.name}"
    end

    #################################################
    #long version
    #genre_array=Genre.all
    #genre_array.sort_by!{|genre| genre.name}
    #genre_array.each_with_index do |genre,index|
      #puts "#{index+1}. #{genre.name}"
    #end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input=gets.strip


    #Stringing methods together like crazy
    #doesn't require local variable to temporarily store array

    #In the Song class get the all array and select all songs
    #with artist name that equals input, then sort the array
    #by song name and then puts...
    Song.all.select{|song|song.artist.name==input}.sort_by{|song| song.name}.each_with_index do |song,index|
      puts "#{index+1}. #{song.name} - #{song.genre.name}"
    end

    ##################################################
    #Long version, requires temp local variable
    #song_array=Song.all.select{|song|song.artist.name==input}
    #song_array.sort_by!{|song| song.name}
    #song_array.each_with_index do |song,index|
      #puts "#{index+1}. #{song.name} - #{song.genre.name}"
    #end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input=gets.strip

    #short version
    Song.all.select{|song|song.genre.name==input}.sort_by{|song| song.name}.each_with_index do |song,index|
      puts "#{index+1}. #{song.artist.name} - #{song.name}"
    end

    #########################################################
    #long version
    #genre_array=Song.all.select{|song|song.genre.name==input}
    #genre_array.sort_by!{|song| song.name}
    #genre_array.each_with_index do |song,index|
      #puts "#{index+1}. #{song.artist.name} - #{song.name}"
    #end
  end

  def play_song
    #It seems easier to create a local variable, song_array
    #to store songs because I use song_array several times
    #in this method.
    song_array=Song.all.sort_by!{|song| song.name}
    #song_array.sort_by!{|song| song.name}

    puts "Which song number would you like to play?"
    input=gets.strip.to_i

    if input>0 && input<song_array.length
      puts "Playing #{song_array[input-1].name} by #{song_array[input-1].artist.name}"
    end
  end

end
