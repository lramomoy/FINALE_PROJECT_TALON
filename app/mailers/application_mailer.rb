class ApplicationMailer < ActionMailer::Base
  default from: 'MB Beauty Parlor <donotreply@example.com>'
  layout 'mailer'

  def send_booking_confirmation_to_customer(booking)
    @booking = booking
    mail(:to => booking.customer.email, :subject => "Your appointment for date: #{@booking.booking_date} has been confirmed")
  end
end
