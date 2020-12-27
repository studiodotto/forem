module Search
  class MusicTrackSerializer < ApplicationSerializer
    attribute :id, &:search_id

    attributes :title, :summary, :class_name, :path,
               :published, :published_at, :search_score

    attribute :main_image do |pde|
      Images::Profile.call(pde.music_release.profile_image_url, length: 90)
    end
    attribute :slug, &:music_release_slug

    attribute :user do |pde|
      NestedUserSerializer.new(pde.music_release.user).serializable_hash.dig(
          :data, :attributes
      )
    end
  end
end
