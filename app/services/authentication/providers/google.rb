module Authentication
  module Providers
    # Google authentication provider, uses omniauth-twitter as backend
    class Google < Provider
      SETTINGS_URL = "https://google.com/settings/applications".freeze

      def new_user_data
        name = raw_info.name.presence || info.name
        remote_profile_image_url = info.image.to_s.gsub("_normal", "")

        {
          email: info.email.to_s,
          name: name,
          remote_profile_image_url: remote_profile_image_url,
          google_created_at: raw_info.created_at || DateTime.now,
          google_url: raw_info.try(:urls) ? raw_info.urls.google.to_s : "",
          google_username: info.email.to_s
        }
      end

      def existing_user_data
        {
          google_created_at: raw_info.created_at || DateTime.now,
          google_url: raw_info.try(:urls) ? raw_info.urls.google.to_s : ""
        }
      end

      def self.settings_url
        SETTINGS_URL
      end

      def self.sign_in_path(**kwargs)
        # see https://github.com/arunagw/omniauth-twitter#authentication-options
        mandatory_params = { secure_image_url: true }

        ::Authentication::Paths.sign_in_path(
          "google_oauth2",
          **kwargs.merge(mandatory_params),
        )
      end

      protected

      def cleanup_payload(auth_payload)
        auth_payload.tap do |auth|
          # Twitter sends the server side access token keys in the payload
          # for each authentication. We definitely do not want to store those
          auth.extra.delete("access_token")
        end
      end
    end
  end
end
