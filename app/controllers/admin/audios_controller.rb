module Admin
  class AudiosController < Admin::ApplicationController
    layout "admin"

    def index
      @audios = Audio
               .order(created_at: :desc)
      # @audios = @audio.result.page(params[:page] || 1).per(15)
    end

    def update
      audio = Audio.find(params[:id])
      if params[:status].present?
        status = params[:status] == 'reject' ? false : true
        update = audio.update(status: status)
        if update
          flash[:notice] = 'record updated successfully'
          redirect_to admin_audios_path
        else
          flash[:alert] = 'cannot update record'
          redirect_to admin_audios_path
        end
      else
        music_track = MusicTrack.find_by(slug: audio.slug)
        if music_track.present?
          music_track.update(title: params[:audio][:name], slug: params[:audio][:slug])
        end
        if audio.update(name: params[:audio][:name], slug: params[:audio][:slug])
          flash[:notice] = 'record updated successfully'
          redirect_to admin_audios_path
        else
          flash[:alert] = 'cannot update record'
          redirect_to admin_audios_path
        end
      end
    end

    def update_audio
      audio = Audio.find(params[:id])
      if params[:status].present?
        status = params[:status] == 'reject' ? false : true
        update = audio.update(status: status)
        if update
          flash[:notice] = 'record updated successfully'
          redirect_to admin_music_releases_path
        else
          flash[:alert] = 'cannot update record'
          redirect_to admin_music_releases_path
        end
      end
    end

    def update_project
      org = Organization.find(params[:id])
      if params[:status].present?
        status = params[:status] == 'reject' ? false : true
        update = org.update(status: status)
        if update
          flash[:notice] = 'record updated successfully'
          redirect_to admin_music_releases_path
        else
          flash[:alert] = 'cannot update record'
          redirect_to admin_music_releases_path
        end
      end
    end

    def edit
      @audio = Audio.find(params[:id])
    end
  end
end
