class SongsController < ApplicationController
    require 'rack-flash'
   use Rack::Flash

    get '/songs' do 
        @songs = Song.all 
        erb :'songs/index'
    end

    get '/songs/new' do 
        @genres = Genre.all
        @artists = Artist.all
        erb :'/songs/new'
    end

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end

    get '/songs/:slug/edit' do 
        @genres = Genre.all
        @artists = Artist.all
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/edit'
    end

    post '/songs' do 
        song = Song.create(params[:song])
        if !params[:artist][:name].empty?
            artist = Artist.find_or_create_by(params[:artist])
            artist.songs << song
            song.artist = artist
        end
        flash[:message] = "Successfully created song."
        redirect "/songs/#{song.slug}"
    end

    patch '/songs/:slug' do 
        song = Song.find_by_slug(params[:slug])
        song.update(params[:song])
        if !params[:artist][:name].empty?
            artist = Artist.create(params[:artist])
            artist.songs << song
            song.artist = artist
        end
        flash[:message] = "Successfully updated song."
        redirect "/songs/#{song.slug}"
    end
end