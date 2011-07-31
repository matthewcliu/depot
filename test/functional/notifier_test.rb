require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    #Send order using order :one
    mail = Notifier.order_received(orders(:one))
    
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["mofo1@gmail.com"], mail.to
    assert_equal ["Matt@learningrails.com"], mail.from
    #Regular expression of a product in the email
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "order_shipped" do
    mail = Notifier.order_shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["mofo1@gmail.com"], mail.to
    assert_equal ["Matt@learningrails.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.body.encoded
  end

end
