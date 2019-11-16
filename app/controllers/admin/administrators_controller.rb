module Admin
  class AdministratorsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    def update
        if requested_resource.update_without_password(resource_params)
            if params[:administrator].try(:[], 'password').present?
                requested_resource.password = requested_resource.password_confirmation = params[:administrator].try(:[], 'password')
                requested_resource.save
                sign_in(requested_resource, :bypass => true) if requested_resource == current_administrator
            end
            redirect_to(
                [namespace, requested_resource],
                notice: translate_with_resource("update.success"),
            )
        else
            render :edit, locals: {
            page: Administrate::Page::Form.new(dashboard, requested_resource),
            }
        end
    end


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
