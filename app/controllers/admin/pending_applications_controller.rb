module Admin
  class PendingApplicationsController < Admin::ApplicationController
    skip_before_action :authorize_admin
    skip_after_action :verify_authorized
    layout "admin"

    def index
      @applicants = User.with_role(:applicant).order(created_at: 'desc')
      # @audios = @audio.result.page(params[:page] || 1).per(15)
    end

    def approve
      user = User.find(params[:id])
      user.update(is_verified: true)
      user.articles.update_all(published: true, published_at: Time.now.utc)
      user.remove_role(:applicant)
      user.add_role(:artist)
      user.artist_application.update_column(:status, true)
      VerificationMailer.with(user_id: user.id).artist_verified.deliver_now
      flash[:success] = "Application has been approved successfully"
      redirect_to admin_pending_applications_index_path
    end

    private

    def authorize_admin
      true
    end
  end
end
