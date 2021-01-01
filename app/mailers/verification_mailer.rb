class VerificationMailer < ApplicationMailer
  default from: lambda {
    "#{SiteConfig.community_name} <#{SiteConfig.email_addresses[:default]}>"
  }

  def account_ownership_verification_email
    @user = User.find(params[:user_id])
    email_authorization = EmailAuthorization.create!(user: @user, type_of: "account_ownership")
    @confirmation_token = email_authorization.confirmation_token

    mail(to: @user.email, subject: "Verify Your #{SiteConfig.community_name} Account Ownership")
  end

  def user_documents_email
    @user = User.find(params[:user_id])
    mail(to: @user.email, subject: "Additional Documents Needed For #{SiteConfig.community_name} Account")
  end

  def artist_verified
    @user = User.find(params[:user_id])
    mail(to: @user.email, subject: "Verification successful")
  end
end
