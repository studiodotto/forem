class MusicReleasesController < ApplicationController
  before_action :authenticate_user!

  # skip Bullet on create as it currently triggers an error inside the rolify
  # method "current_user.add_role()" we have no control of
  around_action :skip_bullet, only: %i[create], if: -> { defined?(Bullet) }

  IMAGE_KEYS = %w[image pattern_image].freeze

  def new
    @music_release = MusicRelease.new
    @music_releases = MusicRelease.published.order(title: :asc)
    @music_release_index = true
  end

  def create
    unless valid_images?
      render :new
      return
    end

    @music_release = MusicRelease.new(music_release_params)
    @music_release.user = current_user

    if @music_release.save
      flash[:global_notice] = "Music release suggested"

      redirect_to music_releases_path
    else
      @music_releases = MusicRelease.published.order(title: :asc)
      @music_releases_index = true

      render :new
    end
  end

  private

  def music_release_params
    allowed_params = %i[
      main_color_hex pattern_image image
      slug title description
    ]
    params.require(:music_release).permit(allowed_params)
  end

  def skip_bullet
    previous_value = Bullet.enable?
    Bullet.enable = false

    yield
  ensure
    Bullet.enable = previous_value
  end

  def valid_images?
    images = music_release_params.slice(*IMAGE_KEYS)
    return true if images.blank?

    # Create the podcast object to add errors to for the view
    @music_release = MusicRelease.new(music_release_params.except(*IMAGE_KEYS))
    @music_release.user = current_user
    return true if valid_image_files_and_names?(images)

    @music_release = MusicRelease.published.order(title: :asc)
    @music_release_index = true
    false
  end

  def valid_image_files_and_names?(images)
    images.each do |field, image|
      @music_release.errors.add(field, IS_NOT_FILE_MESSAGE) unless file?(image)
      break if @music_release.errors.any?

      @music_release.errors.add(field, FILENAME_TOO_LONG_MESSAGE) if long_filename?(image)
    end

    @music_release.errors.blank?
  end
end

