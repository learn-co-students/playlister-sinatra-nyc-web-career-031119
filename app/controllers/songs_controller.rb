require 'sinatra/base'
require 'rack-flash'

class SongsController < ApplicationController


  # GET: /songs
  get "/songs" do
    @songs = Song.all

    erb :"/songs/index.html"
  end

  # GET: /songs/new
  get "/songs/new" do
    erb :"/songs/new.html"
  end

  # POST: /songs
  post "/songs" do
    @song = Song.new(name: params["Name"])
    @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end

  # GET: /songs/5
  get "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])

    erb :"/songs/show.html"
  end

  # GET: /songs/5/edit
  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/edit.html"
  end

  # PATCH: /songs/5
  patch "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end

  # DELETE: /songs/5/delete
  delete "/songs/:id/delete" do
    redirect "/songs"
  end
end
