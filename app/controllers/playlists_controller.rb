class PlaylistsController < ApplicationController
  def index
    @podcasts = Podcast.available.order(title: :asc)
  end

  def new
    @playlist = Playlist.new
  end
  def create

  end
end
