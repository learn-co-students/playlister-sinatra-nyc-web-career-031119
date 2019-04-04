class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash


  get '/songs' do
    @songs = Song.all
    erb :"/songs/index"
  end

  get '/songs/new' do
    erb :"/songs/new"
  end

  post '/songs' do
    artist = Artist.find_or_create_by(name: params["Artist Name"])
    song = Song.create(name: params[:Name], artist_id: artist.id)
    params[:genres].each do |genre|
      SongGenre.create(song_id: song.id, genre_id: genre.to_i)
    end
    flash[:message] = "Successfully created song."
    redirect :"/songs/#{song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/show"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @my_genres = @song.genres.ids
    @check = ""
    erb :"/songs/edit"
  end

  patch '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    artist = Artist.find_or_create_by(name: params["Artist Name"])
    song.name = params[:Name]
    song.artist_id = artist.id
    SongGenre.delete(song.song_genres.ids)
    params[:genres].each do |genre|
      SongGenre.create(song_id: song.id, genre_id: genre.to_i)
    end
    song.save

    flash[:message] = "Successfully updated song."
    redirect :"/songs/#{song.slug}"
  end

end
