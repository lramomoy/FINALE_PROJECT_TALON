require 'csv'
module Admin
  class ReportsController < Admin::ApplicationController
    def new_booking_report

      @bookings = if params['search'].present?
        Booking.includes(:customer, :service).where("booking_date >= (?) AND booking_date <= (?)", params[:search][:start_date], params[:search][:end_date])
      else
        Booking.includes(:customer, :service)
      end

      if params[:commit] == 'Save as Excel File'
        generate_report
      else
        @bookings = order.apply(@bookings)
        @bookings = @bookings.page(params[:page]).per(records_per_page)
      end
    end
    private
    def generate_report
      file = Tempfile.new(["bookings_report",'.csv'])
      CSV.open(file.path, "wb") do |csv|
        csv << ['Customer Name', 'Customer Email', 'Customer Phone', 'Service', 'Booking Date', 'Booking Slot', 'Special Request']

        @bookings.order('booking_date asc').each do |i|
          csv << [
            i.customer.full_name,
            i.customer.email,
            i.customer.phone_number,
            i.service&.name,
            i.booking_date,
            i.booking_time,
            i.special_request
          ]
        end
      end
      File.wait_until_file_is_written_to_disk file.path
      send_file file.path
    end


    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   foo = Foo.find(params[:id])
    #   foo.update(params[:foo])
    #   send_foo_updated_email
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #  if current_user.super_admin?
    #    resource_class
    #  else
    #    resource_class.with_less_stuff
    #  end
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
