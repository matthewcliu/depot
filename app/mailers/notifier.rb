class Notifier < ActionMailer::Base
  #Certain mail values are common to all calls, and can be placed in mail defaults
  default :from => "Matt@learningrails.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order = order

    #mail is a method. In this case it sends to the email address from the order class.
    mail :to => order.email, :subject => 'Pragmatic Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order = order

    mail :to => order.email, :subject => 'Pragmatic Store Order Shipped'
  end
end
