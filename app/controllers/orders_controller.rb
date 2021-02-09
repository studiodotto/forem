class OrdersController < ApplicationController
  after_action :verify_authorized!, except: %i[create]
  before_action :authenticate_user!, except: %i[create]
  before_action :initialize_stripe
  def create
    @user = find_or_create_user
    if @user.present?
      find_or_create_customer
      find_or_create_card
      music_release = MusicRelease.find(params[:music_release_id])
      if @card.present?
        charge = Payments::Customer.charge(
            customer: @customer,
            amount: (params[:project_price].to_f * 100).to_i,
            description: "Purchase of product #{params[:music_release_id]}",
            card_id: @card&.id,
            )
        if charge.present?
          order = Order.create({
            organization_id: music_release.organization.id,
            status: 'accepted',
            total_amount: params[ :project_price].to_f,
            email: @user.email,
            seller_id: music_release.organization.artist.id,
            buyer_id: @user.id,
            release_id: music_release.id,
            event_type: 'single_track',
            order_type: 'single_track',
         })
          if order.present?
            flash[:order_placed] = "Order has been placed"
            return redirect_to organization_feeds_path
          else
            flash[:error] = order.errors.full_messages.to_sentence
            return redirect_to organization_feeds_path
          end
        end
      else
        # DatadogStatsClient.increment("stripe.errors", tags: ["action:create_card", "user_id:#{current_user.id}"])
        flash[:error] = "There was a problem adding your card"
        return redirect_to organization_feeds_path
      end
    end
  rescue Payments::PaymentsError => e
    redirect_to organization_feeds_path, flash: { error: e.message }
  end

  private

  def find_or_create_user
    user = nil
    if current_user.present?
      user = current_user
    else
      new_user = User.create({
         first_name: params[:first_name],
         last_name: params[:last_name],
         email: params[:email],
         password: params[:password],
         password_confirmation: params[:password],
         saw_onboarding: true,
         registered: true,
         registered_at: Time.current,
         editor_version: "v2",
         username: params[:first_name] + SecureRandom.hex(2)
      })
      if new_user.errors.any?
        return redirect_to organization_feeds_path, flash: { error: new_user.errors.full_messages.to_sentence }
      end
      user = new_user
      user.add_role :customer
    end
    user
  end

  def find_customer
    Payments::Customer.get(@user.stripe_id_code)
  end

  def find_or_create_customer
    if @user.stripe_id_code.present?
      @customer = find_customer
    else
      @customer = Payments::Customer.create(email: @user.email).tap do |customer|
        @user.update(stripe_id_code: customer.id)
      end
    end
  end

  def find_or_create_card
    @card = if params[:stripe_token]
              Payments::Customer.create_source(@customer.id, params[:stripe_token])
            else
              @customer.default_source
            end
  end

  def stripe_params
    params.permit(%i[stripe_token])
  end
end
