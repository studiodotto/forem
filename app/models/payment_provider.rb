class PaymentProvider < ApplicationRecord
  belongs_to :user
  def dashboard_link
    account = Stripe::Account.retrieve(external_id)
    res = account.login_links.create()
    res.url
  end
end
