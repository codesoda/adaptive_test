class PaymentsController < ApplicationController

  def index

    gateway =  ActiveMerchant::Billing::PaypalAdaptivePayment.new(
      :login => "####",
      :password => "####",
      :signature => "####",
      :appid => "####"
    )

    recipients = [{
      :email => 'recipient1@example.com',
      :amount => 100.0,
      :primary => true
    }, {
      :email => 'recipient2@example.com',
      :amount => 1.0,
      :primary => false
    }]

  @response = @gateway.setup_purchase(
    :return_url => url_for(:action => 'return', :only_path => false),
    :cancel_url => url_for(:action => 'cancel', :only_path => false),
    :ipn_notification_url => url_for(:action => 'notify', :only_path => false),
    :receiver_list => recipients
  )

  # For redirecting the customer to the actual paypal site to finish the payment.
  redirect_to (@gateway.redirect_url_for(@response["payKey"])) unless @response[:error]

  end

  def return
  end

  def cancel
  end

  def notify
  end

end
