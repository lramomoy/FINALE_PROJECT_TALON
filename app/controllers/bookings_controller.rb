class BookingsController < ApplicationController

  def new
    @booking = Booking.new
  end

  def create
    @customer = Customer.find_or_initialize_by({
      first_name: params[:customer][:first_name],
      last_name: params[:customer][:last_name],
      email: params[:customer][:email]
    })
    @customer.phone_number = params[:customer][:phone_number]
    @customer.save

    @booking = @customer.bookings.find_or_initialize_by(booking_params)
    if @booking.save
      ApplicationMailer.send_booking_confirmation_to_customer(@booking).deliver
      redirect_to booking_status_url(@booking)
    else
      render :new
    end
  end

  def status
    @booking = Booking.find_by(id: params[:id])
    redirect_to root_url, notice: 'Invalid Booking ID!' if @booking.nil?
  end

  def get_available_slots
    @available_slots = Booking.available_slots_on(params[:date])
    respond_to do |format|
      format.js
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:service_id, :booking_date, :booking_time, :special_request)
  end
end
