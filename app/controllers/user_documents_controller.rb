class UserDocumentsController < ApplicationController

  def new
    @user_id = params[:user_id]
    payment_provider = PaymentProvider.create(user_id: @user_id)
    send_to_stripe(payment_provider.id)
  end

  def connect
    response = RestClient.post "https://connect.stripe.com/oauth/token", {
        client_secret: SiteConfig.stripe_api_key,
        code: params[:code],
        grant_type: "authorization_code"
    }

    data = JSON.parse(response.body)

    provider_id = cookies[:connect]
    payment_provider = PaymentProvider.find(provider_id)
    payment_provider.update(external_id: data["stripe_user_id"], access_token: data["access_token"], refresh_token: data["refresh_token"])
    VerificationMailer.with(user_id: payment_provider.user.id).artist_verified.deliver_now
    redirect_to verified_user_documents_path
  end

  def verified
  end

  def send_to_stripe(payment_provider_id)
    url = "https://connect.stripe.com/express/oauth/authorize?response_type=code&client_id=#{SiteConfig.connect_key}&scope=read_write"
    if Rails.env.production?
      # cookies.permanent[:connect] = {
      #     value: "#{current_customer.id}:#{ApiBase.auth_token}:#{request.host}:#{@payment_provider.id}",
      #     domain: :all
      # }
      cookies.permanent[:connect] = payment_provider_id
    else
      cookies.permanent[:connect] = payment_provider_id
    end

    redirect_to url
  end
end
