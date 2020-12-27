module Admin
  class MusicReleasesController < Admin::ApplicationController
    layout "admin"

    before_action :find_music_release, only: %i[edit update]
    # before_action :find_user, only: %i[remove_admin add_admin]

    def index
      @music_releases = MusicRelease.left_outer_joins(:music_tracks)
                      .select("music_releases.*, count(music_tracks) as tracks_count")
                      .group("music_releases.id").order("music_releases.created_at" => :desc)
                      .page(params[:page]).per(50)

      return if params[:search].blank?

      @music_releases = @music_releases.where("music_releases.title ILIKE :search", search: "%#{params[:search]}%")
    end

    def edit; end

    def update
      if @music_release.update(music_release_params)
        redirect_to admin_music_releases_path, notice: "Music release updated"
      else
        render :edit
      end
    end

    # def fetch
    #   limit = params[:limit].to_i.zero? ? nil : params[:limit].to_i
    #   force = params[:force].to_i == 1
    #   Podcasts::GetEpisodesWorker.perform_async(podcast_id: @podcast.id, limit: limit, force: force)
    #   flash[:notice] = "Podcast's episodes fetching was scheduled (#{@podcast.title}, ##{@podcast.id})"
    #   redirect_to admin_podcasts_path
    # end

    # def remove_admin
    #   removed_roles = @user.remove_role(:podcast_admin, @podcast)
    #   if removed_roles.empty?
    #     redirect_to edit_admin_podcast_path(@podcast), notice: "Error"
    #   else
    #     redirect_to admin_podcasts_path, notice: "Removed admin"
    #   end
    # end
    #
    # def add_admin
    #   role = @user.add_role(:podcast_admin, @podcast)
    #   if role.persisted?
    #     redirect_to admin_podcasts_path, notice: "Added admin"
    #   else
    #     redirect_to edit_admin_podcast_path(@podcast), notice: "Error"
    #   end
    # end

    private

    def find_music_release
      @music_release = MusicRelease.find(params[:id])
    end

    # def find_user
    #   @user = User.find_by(id: params[:music_release][:user_id])
    #   redirect_to edit_admin_music_release_path(@music_release), notice: "No such user" unless @user
    # end

    def music_release_params
      allowed_params = %i[
        title
        description
        pattern_image
        main_color_hex
        slug
        image
        published
      ]
      params.require(:music_release).permit(allowed_params)
    end
  end
end
